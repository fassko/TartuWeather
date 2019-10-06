//
//  TartuWeatherViewModel.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 13/06/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import Foundation

import TartuWeatherProvider

struct WeatherData {
  let temperature: String
  let wind: String
  let measuredTime: String
  let largeImage: String
  let smallImage: String
}

struct TartuWeatherViewModel {
  
//  /// Temperature
//  public var temperature = BehaviorRelay<String?>(value: nil)
//
//  /// Wind
//  public var wind = BehaviorRelay<String?>(value: nil)
//
//  /// Measured time
//  public var measuredTime = BehaviorRelay<String?>(value: nil)
//
//  /// Live image large
//  public var largeImage = BehaviorRelay<String?>(value: nil)
//
//  /// Live image small
//  public var smallImage = BehaviorRelay<String?>(value: nil)
  
  /**
    Update weather from API
  */
  func getWeatherData(_ callback: @escaping (WeatherData) -> Void) {
  
    // Get weather data
    TartuWeatherProvider.getWeatherData { result in
    
      switch result {
      case .failure(let error):
        debugPrint("Can't get weather data \(String(describing: error))")
        
      case .success(let data):
        let weatherData = WeatherData(temperature: data.temperature,
                                      wind: "\(data.windDirection) \(data.wind)",
                                      measuredTime: data.measuredTime,
                                      largeImage: data.liveImage.large,
                                      smallImage: data.liveImage.small)
        callback(weatherData)
      }
    }
  }
}
