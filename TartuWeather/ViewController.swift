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
import Agrume

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
  
  //MARK:- Class variables
  /// View model
  private var tartuWeatherViewModel: TartuWeatherViewModel = TartuWeatherViewModel()
  
  /// Live image
  var agrume: Agrume?
  
  
  //MARK:- View lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up labels bindings
    tartuWeatherViewModel.temperature.asObservable().bind(to: temperatureLabel.rx.text).addDisposableTo(rx.disposeBag)
    tartuWeatherViewModel.wind.asObservable().bind(to: windLabel.rx.text).addDisposableTo(rx.disposeBag)
    tartuWeatherViewModel.measuredTime.asObservable().bind(to: measuredTimeLabel.rx.text).addDisposableTo(rx.disposeBag)
    
    /// Set up live image binding
    tartuWeatherViewModel.largeImage.asObservable()
      .filterNil()
      .subscribe(onNext: {imageURL in
        self.getLiveImage(imageURL)
      })
      .addDisposableTo(rx.disposeBag)
    
    // Update weather data when application did become active
    Observable.of(NotificationCenter.default.rx.notification(NSNotification.Name.UIApplicationDidBecomeActive), NotificationCenter.default.rx.notification(NSNotification.Name.UIApplicationWillEnterForeground))
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .addDisposableTo(rx.disposeBag)
   
    // Refresh button
    let refresh = refreshButton.rx.tap
    refresh
      .asObservable()
      .subscribe(onNext: {
        self.tartuWeatherViewModel.updateWeather()
      })
      .addDisposableTo(rx.disposeBag)
    
    // Update weather data with timer
    Observable<Int>
      .interval(RxTimeInterval(30), scheduler: MainScheduler.instance)
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .addDisposableTo(rx.disposeBag)
  }
  
  
  //MARK: - Actions
  /**
    Show live image
   
    - Parameters:
      - sender: Tap recognizer of image
   
  **/
  @IBAction func showImage(_ sender: UITapGestureRecognizer) {
    agrume?.showFrom(self)
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
      
      self.agrume = Agrume(image: image, backgroundColor: .black)
      self.agrume?.hideStatusBar = true
    }
  }
  
}
