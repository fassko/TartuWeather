//
//  ViewController.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import QuartzCore

import RxSwift
import RxCocoa
import NSObject_Rx
import AlamofireImage
import Alamofire
import RxOptional
import Lightbox

class ViewController: UIViewController {

  //MARK:- Interface
  /// Temperature label
  @IBOutlet weak var temperatureLabel: UILabel!
  
  /// Wind label
  @IBOutlet weak var windLabel: UILabel!
  
  /// Current image label
  @IBOutlet weak var currentImage: UIImageView!
  
  /// Measured time label
  @IBOutlet weak var measuredTimeLabel: UILabel!
  
  /// Refresh label
  @IBOutlet weak var refreshButton: UIBarButtonItem!
  
  /// Share button
  @IBOutlet var shareButton: UIBarButtonItem!
  
  
  //MARK:- Class variables
  /// View model
  private var tartuWeatherViewModel: TartuWeatherViewModel = TartuWeatherViewModel()
  
  /// Live image
  var lightboxController: LightboxController?
  
  /// Pull to refresh control
  let refreshControl = UIRefreshControl()
  
  
  //MARK:- View lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shareButton.isEnabled = false
    
    /// Set up live image binding
    tartuWeatherViewModel.largeImage.asObservable()
      .filterNil()
      .subscribe(onNext: {imageURL in
        self.shareButton.isEnabled = true
        self.refreshControl.endRefreshing()
        
        self.getLiveImage(imageURL)
      })
      .disposed(by: rx.disposeBag)
    
    // Set up labels bindings
    tartuWeatherViewModel.temperature.asObservable().bind(to: temperatureLabel.rx.text).disposed(by: rx.disposeBag)
    tartuWeatherViewModel.wind.asObservable().bind(to: windLabel.rx.text).disposed(by: rx.disposeBag)
    tartuWeatherViewModel.measuredTime.asObservable().bind(to: measuredTimeLabel.rx.text).disposed(by: rx.disposeBag)
    
    // Update weather data when application did become active
    Observable.of(NotificationCenter.default.rx.notification(NSNotification.Name.UIApplicationDidBecomeActive), NotificationCenter.default.rx.notification(NSNotification.Name.UIApplicationWillEnterForeground))
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .disposed(by: rx.disposeBag)
   
    // Refresh button
    let refresh = refreshButton.rx.tap
    refresh
      .asObservable()
      .subscribe(onNext: {
        self.tartuWeatherViewModel.updateWeather()
      })
      .disposed(by: rx.disposeBag)
    
    // Update weather data with timer
    Observable<Int>
      .interval(RxTimeInterval(30), scheduler: MainScheduler.instance)
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .disposed(by: rx.disposeBag)
    
    // Add pull to refresh
    refreshControl.tintColor = UIColor(red:0.18, green:0.35, blue:0.50, alpha:1.0)
    refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    (view as! UIScrollView).refreshControl = refreshControl
  }
  
  //MARK: - Actions
  /**
    Show live image
   
    - Parameters:
      - sender: Tap recognizer of image
   
  **/
  @IBAction func showImage(_ sender: UITapGestureRecognizer) {
    guard let lightbox = lightboxController else { return }
    present(lightbox, animated: true, completion: nil)
  }
  
  //MARK: - Additional methods
  /**
    Get live image from Internet and update imageview
   
    - Parameters:
      - imageURL: Image String URL
  */
  fileprivate func getLiveImage(_ imageURL: String) {
    Alamofire.request(imageURL).responseImage { response in
      guard let image = response.result.value else { return }
      
      self.currentImage.image = image
      
      self.lightboxController = LightboxController(images: [LightboxImage(image: image)])
      self.lightboxController?.dynamicBackground = true
      self.lightboxController?.pageDelegate = nil
    }
  }
  
  /**
    Pull to refresh data
   
    - Parameters:
      - refreshControl: Refresh control
  */
  @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
    tartuWeatherViewModel.updateWeather()
  }
  
  /**
    Share temperature and wind
  */
  @IBAction func share(_ sender: Any) {
    guard let temperature = tartuWeatherViewModel.temperature.value, let wind = tartuWeatherViewModel.wind.value else { return }
  
    let activityViewController = UIActivityViewController(activityItems: ["\(String(describing: temperature)), \(String(describing: wind))"], applicationActivities: nil)
    navigationController?.present(activityViewController, animated: true, completion: {})
  }
}
