//
//  TartuWeatherProvider.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 02/12/2016.
//
//

import Foundation

#if os(OSX)
    import AppKit
    public typealias LiveImage = NSImage
#else
    import UIKit
    public typealias LiveImage = UIImage
#endif

import Alamofire
import AlamofireImage


/// Tartu Weather Provider
open class TartuWeatherProvider {

  /**
    Get weather data by parsing HTML
    
    - Parameters:
      - completion: Callback block when data is retrieved from server
      - data: Weather data struct
   
  */
  open class func getWeatherData(completion:@escaping (_ data:WeatherData?, _ error:Error?) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/en/frontmain.php?m=2").responseString(completionHandler: {
      response in
      
        switch response.result {
          
          case .failure(let error):
          
            completion(nil, error)
        
          case .success:
          
            if let temperature = response.result.value?.components(separatedBy: "Temperature</A></TD><TD align=\"left\" width=\"45%\"><B>")[1].components(separatedBy: "</B>")[0].replacingOccurrences(of: "&deg;", with: "°"),
              let humidity = response.result.value?.components(separatedBy: "Humidity</A></TD><TD align=\"left\" width=\"45%\"><B>")[1].components(separatedBy: "</B>")[0],
              let airPressure = response.result.value?.components(separatedBy: "Air pressure</A></TD><TD align=\"left\" width=\"45%\"><B>")[1].components(separatedBy: "</B>")[0],
              let wind = response.result.value?.components(separatedBy: "Wind</A></TD><TD align=\"left\" width=\"45%\"><B>")[1].components(separatedBy: "</B>")[0],
              let precipitation = response.result.value?.components(separatedBy: "Precipitation</A></TD><TD align=\"left\" width=\"45%\"><B>")[1].components(separatedBy: "</B>")[0],
              let irradiationFlux = response.result.value?.components(separatedBy: "Irradiation flux</A></TD><TD align=\"left\" width=\"45%\"><B>")[1].components(separatedBy: "</sup>")[0].replacingOccurrences(of: "<sup>", with: "^"),
              let measuredTime = response.result.value?.components(separatedBy: "Measured</SMALL></TD><TD colspan=\"2\"><SMALL><I>")[1].components(separatedBy: "</I>")[0]
            {
              let data = WeatherData(temperature: temperature, humidity: humidity, airPressure: airPressure, wind: wind, precipitation: precipitation, irradiationFlux: irradiationFlux, measuredTime: measuredTime)
            
              completion(data, nil)
            }
        }
    })
  }

  /**
    Get current weather image from webcam
    
    - Parameters:
      - completion: Callback block when data is retrieved from server
      - image: UIImage with current webcam image
   
  */
  open class func getCurrentImage(completion:@escaping (_ image:LiveImage) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/webcam/uus/suur.jpg").responseImage { response in

      if let image = response.result.value {
        completion(image)
      }
    }
  }
}
