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
  var temperature = Variable<String?>("")
  
  /// Wind
  var wind = Variable<String?>("")
 
  /// Measured time
  var measuredTime = Variable<String?>("")
  
  var liveImage = Variable<UIImage?>(nil)
  
  init() {
    self.updateWeather()
  }
  
  /**
    Update weather from API
  */
  func updateWeather() {
  
    TartuWeatherProvider.getWeatherData(completion: {data, error in
      
      guard let temp = data?.temperature, let w = data?.wind, let time = data?.measuredTime
, error == nil else {
        debugPrint("Can't get weather data \(error)")
        return
      }
      
      self.temperature.value = temp
      self.wind.value = w
      self.measuredTime.value = time
    })
    
    TartuWeatherProvider.getCurrentImage(completion: {image, error in
      
      guard let img = image, error == nil else {
        debugPrint("Can't get live image \(error)")
        return
      }
      
      self.liveImage.value = img
    })

  }
}
