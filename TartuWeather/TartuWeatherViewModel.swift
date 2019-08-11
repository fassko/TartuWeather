//
//  TartuWeatherViewModel.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 13/06/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import Foundation
import UIKit

import TartuWeatherProvider
import RxCocoa
import RxSwift

struct TartuWeatherViewModel {
  
  /// Temperature
  public var temperature = BehaviorRelay<String?>(value: nil)
  
  /// Wind
  public var wind = BehaviorRelay<String?>(value: nil)
 
  /// Measured time
  public var measuredTime = BehaviorRelay<String?>(value: nil)
  
  /// Live image large
  public var largeImage = BehaviorRelay<String?>(value: nil)
  
  /// Live image small
  public var smallImage = BehaviorRelay<String?>(value: nil)
  
  init() {
    updateWeather()
  }
  
  /**
    Update weather from API
  */
  func updateWeather() {
  
    // Get weather data
    TartuWeatherProvider.getWeatherData { result in
    
      switch result {
      case .failure(let error):
        debugPrint("Can't get weather data \(String(describing: error))")
        
      case .success(let data):
        self.temperature.accept(data.temperature)
        self.wind.accept("\(data.windDirection) \(data.wind)")
        self.measuredTime.accept(data.measuredTime)
        
        self.largeImage.accept(data.liveImage.large)
        self.smallImage.accept(data.liveImage.small)
      }
    }
  }
}
