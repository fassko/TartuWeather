//
//  ViewController.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import QuartzCore
import Intents

import RxSwift
import RxCocoa
import Lightbox

class NowViewController: UIViewController {

  // MARK: - Interface
  /// Temperature label
  @IBOutlet weak var temperatureLabel: UILabel!
  
  /// Wind label
  @IBOutlet weak var windLabel: UILabel!
  
  /// Current image label
  @IBOutlet weak var currentImage: UIImageView!
  
  /// Measured time label
  @IBOutlet weak var measuredTimeLabel: UILabel!
  
  /// Share button
  @IBOutlet var shareButton: UIBarButtonItem!
  
  // MARK: - Class variables
  /// View model
  private var tartuWeatherViewModel: TartuWeatherViewModel = TartuWeatherViewModel()
  
  /// Live image
  var lightboxController: LightboxController?
  
  /// Pull to refresh control
  let refreshControl = UIRefreshControl()
  
  private let disposeBag = DisposeBag()
  
  private var timer: Timer?
  
  // MARK: - View lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shareButton.isEnabled = false
    
    /// Set up live image binding
    tartuWeatherViewModel.largeImage.asObservable()
      .flatMap({ $0.map { Observable.just($0) } ?? Observable.empty() })
      .subscribe(onNext: {[weak self] imageURL in
        self?.refreshControl.endRefreshing()
        self?.shareButton.isEnabled = true
        
        self?.getLiveImage(imageURL)
      })
      .disposed(by: disposeBag)
    
    // Set up labels bindings
    tartuWeatherViewModel.temperature.asObservable().bind(to: temperatureLabel.rx.text).disposed(by: disposeBag)
    tartuWeatherViewModel.wind.asObservable().bind(to: windLabel.rx.text).disposed(by: disposeBag)
    tartuWeatherViewModel.measuredTime.asObservable().bind(to: measuredTimeLabel.rx.text).disposed(by: disposeBag)
    
    // Update weather data when application did become active
    Observable.of(NotificationCenter.default.rx.notification(NSNotification.Name.NSExtensionHostDidBecomeActive),
                  NotificationCenter.default.rx.notification(NSNotification.Name.NSExtensionHostWillEnterForeground))
      .subscribe(onNext: {[weak self] _ in
        self?.tartuWeatherViewModel.updateWeather()
      })
      .disposed(by: disposeBag)
    
    timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) {[weak self] _ in
      self?.update()
    }
    
    // Add pull to refresh
    refreshControl.tintColor = UIColor(red: 0.18, green: 0.35, blue: 0.50, alpha: 1.0)
    refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    guard let scrollView = view as? UIScrollView else { return }
    scrollView.refreshControl = refreshControl
    
    donateIntents()
  }
  
  @IBAction func refresh(_ sender: Any) {
    update()
  }
  
  func update() {
    tartuWeatherViewModel.updateWeather()
  }
  
  public func donateIntents() {
    if #available(iOS 12.0, *) {
      
      GetTemperatureIntent().donate()
      GetWindIntent().donate()
      
    } else {
    }
  }
  
  // MARK: - Actions
  /**
    Show live image
   
    - Parameters:
      - sender: Tap recognizer of image
   
  **/
  @IBAction func showImage(_ sender: UITapGestureRecognizer) {
    guard let lightboxController = lightboxController else { return }
    lightboxController.modalPresentationStyle = .fullScreen
    present(lightboxController, animated: true, completion: nil)
  }
  
  // MARK: - Additional methods
  /**
    Get live image from Internet and update imageview
   
    - Parameters:
      - imageURL: Image String URL
  */
  fileprivate func getLiveImage(_ imageURL: String) {
    let request = URLRequest(url: URL(string: imageURL)!,
                             cachePolicy: .reloadIgnoringLocalCacheData,
                             timeoutInterval: 60)
    URLSession.shared.dataTask(with: request) {[weak self] data, _, _ in
      DispatchQueue.main.async {
        if let data = data {
          guard let image = UIImage(data: data) else { return }
          self?.currentImage.image = image
        
          self?.lightboxController = LightboxController(images: [LightboxImage(image: image)])
          self?.lightboxController?.dynamicBackground = true
          self?.lightboxController?.pageDelegate = nil
        }
      }
    }.resume()
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
    guard let temperature = tartuWeatherViewModel.temperature.value,
      let wind = tartuWeatherViewModel.wind.value else {
        return
    }
  
    let activityViewController = UIActivityViewController(activityItems:
      ["\(String(describing: temperature)), \(String(describing: wind))"], applicationActivities: nil)
    navigationController?.present(activityViewController, animated: true, completion: {})
  }
}
