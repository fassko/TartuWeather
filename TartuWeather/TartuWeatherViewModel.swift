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
import RxSwift

struct TartuWeatherViewModel {
  
  /// Temperature
  public var temperature = Variable<String?>("")
  
  /// Wind
  public var wind = Variable<String?>("")
 
  /// Measured time
  public var measuredTime = Variable<String?>("")
  
  /// Live image large
  public var largeImage = Variable<String?>(nil)
  
  /// Live image small
  public var smallImage = Variable<String?>(nil)
  
  init() {
    updateWeather()
  }
  
  /**
    Update weather from API
  */
  func updateWeather() {
  
    // Get weather data
    TartuWeatherProvider.getWeatherData(completion: { result in
    
      switch result {
      case .failure(let error):
        debugPrint("Can't get weather data \(String(describing: error))")
        
      case .success(let data):
        self.temperature.value = data.temperature
        self.wind.value = "\(data.windDirection) \(data.wind)"
        self.measuredTime.value = data.measuredTime
        
        self.largeImage.value = data.liveImage.large
        self.smallImage.value = data.liveImage.small
      }
    })
  }
}
