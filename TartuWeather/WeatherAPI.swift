//
//  WeatherAPI.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import Fuzi

class WeatherAPI {

  class func getTemperature(completion:(temperature:String) -> Void) {
    Alamofire.request(.GET, "http://meteo.physic.ut.ee/en/frontmain.php?m=2").responseString {
      response in
        if let doc = try? HTMLDocument(string: response.result.value!, encoding: NSUTF8StringEncoding) {
          if let temperature = doc.css("td > b").first {
            print("getTemperature = \(temperature.stringValue)")
            completion(temperature: temperature.stringValue)
          }
        }
    }
  }
  
  class func getWind(completion:(wind:String) -> Void) {
    Alamofire.request(.GET, "http://meteo.physic.ut.ee/en/frontmain.php?m=2").responseString {
      response in
        if let doc = try? HTMLDocument(string: response.result.value!, encoding: NSUTF8StringEncoding) {
          if let wind = doc.css("td > b")[3] {
            print("getTemperature = \(wind.stringValue)")
            completion(wind: wind.stringValue)
          }
        }
    }
  }
  
  class func getCurrentImage(completion:(image:UIImage) -> Void) {
    Alamofire.request(.GET, "http://meteo.physic.ut.ee/webcam/praegu/small.jpg").responseImage { response in

      if let image = response.result.value {
        completion(image: image)
      }
    }
  }

}