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
        completion(.success(temperature: weatherData.temperature))
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
        completion(.success(speed: weatherData.wind, direction: weatherData.windDirection))
      }
    }
  }
}
