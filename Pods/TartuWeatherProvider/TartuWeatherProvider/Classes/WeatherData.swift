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
  public var temperature: String
  public var humidity:String
  public var airPressure:String
  public var wind:String
  public var precipitation:String
  public var irradiationFlux:String
  public var measuredTime:String
  
  
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
