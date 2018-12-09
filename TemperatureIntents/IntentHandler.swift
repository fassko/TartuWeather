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
    return TemperatureIntentHandler()
  }
}

class TemperatureIntentHandler: NSObject, GetTemperatureIntentHandling {
  func handle(intent: GetTemperatureIntent, completion: @escaping (GetTemperatureIntentResponse) -> Void) {
    TartuWeatherProvider.getWeatherData { result in
      switch result {
      case .success(let weatherData):
        completion(.success(temperature: weatherData.temperature))
      case .failure(let error):
        print("Can't get weather data", error.localizedDescription)
        completion(GetTemperatureIntentResponse.failure(error: error.localizedDescription))
      }
    }
  }
}
