//
//  WeatherData.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 20/02/2017.
//
//

import Foundation

/// Weather data
public struct WeatherData {
  /// Temperature
  public var temperature: String
  
  /// Humidity
  public var humidity:String
  
  /// Air pressure
  public var airPressure:String
  
  /// Wind speed and direction
  public var wind:String
  
  /// Precipitation
  public var precipitation:String
  
  /// Irradiation flux
  public var irradiationFlux:String
  
  /// Measured time
  public var measuredTime:String
  
  /**
    Init method
    
    - Parameters:
      - temperature: Temperature
      - humidity: Humidity
      - airPressure: Air pressure
      - wind: Wind
      - precipitation: Precipitation
      - irradiationFlux: Irradiation flux
      - measuredTime: Measured time
  */
  init(temperature:String, humidity:String, airPressure:String, wind:String, precipitation:String, irradiationFlux:String, measuredTime:String) {
    self.temperature = temperature
    self.humidity = humidity
    self.airPressure = airPressure
    self.wind = wind
    self.precipitation = precipitation
    self.irradiationFlux = irradiationFlux
    self.measuredTime = measuredTime
  }
}
