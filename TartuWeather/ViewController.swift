//
//  ViewController.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import NSObject_Rx

class ViewController: UIViewController {

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
  
  /// View model
  private var tartuWeatherViewModel: TartuWeatherViewModel = TartuWeatherViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up labels bindings
    tartuWeatherViewModel.temperature.asObservable().bind(to: temperatureLabel.rx.text).addDisposableTo(rx_disposeBag)
    tartuWeatherViewModel.wind.asObservable().bind(to: windLabel.rx.text).addDisposableTo(rx_disposeBag)
    tartuWeatherViewModel.measuredTime.asObservable().bind(to: measuredTimeLabel.rx.text).addDisposableTo(rx_disposeBag)
    
    /// Set up live image binding
    tartuWeatherViewModel.liveImage.asObservable().bind(to: currentImage.rx.image).addDisposableTo(rx_disposeBag)
   
    
    // Update weather data when application did become active
    Observable.of(NotificationCenter.default.rx.notification(NSNotification.Name.UIApplicationDidBecomeActive), NotificationCenter.default.rx.notification(NSNotification.Name.UIApplicationWillEnterForeground))
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .addDisposableTo(rx_disposeBag)
   
   
    // Refresh button
    let refresh = refreshButton.rx.tap
    
    refresh
      .asObservable()
      .subscribe(onNext: {
        self.tartuWeatherViewModel.updateWeather()
      })
      .addDisposableTo(rx_disposeBag)
  }
}
