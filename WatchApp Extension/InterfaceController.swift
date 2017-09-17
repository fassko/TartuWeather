//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Kristaps Grinbergs on 05/02/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import WatchKit
import Foundation

import RxSwift
import RxCocoa
import NSObject_Rx
import Alamofire
import AlamofireImage
import RxOptional

class InterfaceController: WKInterfaceController {
  
  /// Current image
  @IBOutlet var currentImage: WKInterfaceImage!
  
  /// Temperature label
  @IBOutlet var tempLabel: WKInterfaceLabel!
  
  /// Wind label
  @IBOutlet var windLabel: WKInterfaceLabel!
  
  /// Measured label
  @IBOutlet var measuredLabel: WKInterfaceLabel!
  
  /// View model
  private var tartuWeatherViewModel = TartuWeatherViewModel()


  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    // Set up labels bindings
    tartuWeatherViewModel.temperature
      .asObservable()
      .subscribe(onNext: {temp in
        self.tempLabel.setText(temp)
      })
      .addDisposableTo(rx.disposeBag)
    
    tartuWeatherViewModel.wind
      .asObservable()
      .subscribe(onNext: {wind in
        self.windLabel.setText(wind)
      })
      .addDisposableTo(rx.disposeBag)
    
    tartuWeatherViewModel.measuredTime
      .asObservable()
      .subscribe(onNext: {time in
        self.measuredLabel.setText(time)
      })
      .addDisposableTo(rx.disposeBag)
    
    // Set up live image binding
    tartuWeatherViewModel.smallImage
      .asObservable()
      .filterNil()
      .subscribe(onNext: {imgURL in
        Alamofire.request(imgURL).responseImage { response in
        
          guard let image = response.result.value else { return }

          self.currentImage.setImage(image)
        }
      })
      .addDisposableTo(rx.disposeBag)
    
    tartuWeatherViewModel.updateWeather()
    
    // Update weather data with timer
    Observable<Int>
      .interval(RxTimeInterval(30), scheduler: MainScheduler.instance)
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .addDisposableTo(rx.disposeBag)
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  /**
    Reload data
  */
  @IBAction func reloadData() {
    WKInterfaceDevice().play(.notification)
    tartuWeatherViewModel.updateWeather()
  }
}
