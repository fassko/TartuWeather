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

class TartuWeatherViewModel {
  
  /// Temperature
  public var temperature = Variable<String?>("")
  
  /// Wind
  public var wind = Variable<String?>("")
 
  /// Measured time
  public var measuredTime = Variable<String?>("")
  
  /// Live image
  public var liveImage = Variable<UIImage?>(nil)
  
  init() {
    self.updateWeather()
  }
  
  /**
    Update weather from API
  */
  func updateWeather() {
  
    // Get weather data
    TartuWeatherProvider.getWeatherData(completion: {data, error in
      
      guard let temp = data?.temperature, let wind = data?.wind , let time = data?.measuredTime
, error == nil else {
        debugPrint("Can't get weather data \(String(describing: error))")
        return
      }
      
      self.temperature.value = temp
      self.wind.value = wind
      self.measuredTime.value = time
    })
    
    // Get live image
    TartuWeatherProvider.getCurrentImage(completion: {image, error in
      
      guard let img = image, error == nil else {
        debugPrint("Can't get live image \(String(describing: error))")
        return
      }
      
      self.liveImage.value = img
    })

  }
}
