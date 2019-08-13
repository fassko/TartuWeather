//
//  IntentHandler.swift
//  TemperatureIntents
//
//  Created by Kristaps Grinbergs on 09/12/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Intents

import TartuWeatherProvider

class IntentHandler: INExtension {
  override func handler(for intent: INIntent) -> Any {
    return SiriIntentHandler()
  }
}

class SiriIntentHandler: NSObject, GetTemperatureIntentHandling, GetWindIntentHandling {
  @available(iOSApplicationExtension 12.0, *)
  func handle(intent: GetTemperatureIntent, completion: @escaping (GetTemperatureIntentResponse) -> Void) {
    TartuWeatherProvider.getWeatherData { result in
      switch result {
      case .success(let weatherData):
        let temperature = weatherData.temperature.replacingOccurrences(of: "°C", with: "° Celcius")
        completion(.success(temperature: temperature))
      case .failure(let error):
        completion(.failure(error: error.localizedDescription))
      }
    }
  }
  
  @available(iOSApplicationExtension 12.0, *)
  func handle(intent: GetWindIntent, completion: @escaping (GetWindIntentResponse) -> Void) {
    TartuWeatherProvider.getWeatherData { result in
      switch result {
      case .failure(let error):
        completion(.failure(error: error.localizedDescription))
      case .success(let weatherData):
        let speed = weatherData.wind.replacingOccurrences(of: "m/s", with: "meter per second")
        let direction = weatherData.windDirection.fullWindDirection
        completion(.success(speed: speed, direction: direction))
      }
    }
  }
}

extension String {
  var fullWindDirection: String {
    switch self {
    case "N":
      return "North"
    case "NNE":
      return "North-Northeast"
    case "NE":
      return "Northeast"
    case "ENE":
      return "East-Northeast"
    case "E":
      return "East"
    case "ESE":
      return "East-Southeast"
    case "SE":
      return "Southeast"
    case "SSE":
      return "South-Southeast"
    case "S":
      return "South"
    case "SSW":
      return "South-Southwest"
    case "SW":
      return "Southwest"
    case "WSW":
      return "West-Southwest"
    case "W":
      return "West"
    case "WNW":
      return "West-Northwest"
    case "NW":
      return "Northwest"
    case "NNW":
      return "North-Northwest"
    default:
      return ""
    }
  }
}
