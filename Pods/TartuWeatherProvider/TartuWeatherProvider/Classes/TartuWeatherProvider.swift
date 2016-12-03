//
//  TartuWeatherProvider.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 02/12/2016.
//
//

import Foundation
import UIKit

import Alamofire
import Fuzi
import AlamofireImage


/// Tartu Weather Provider
open class TartuWeatherProvider {

  /**
    Get weather data by parsing HTML
    
    - Parameters:
      - completion: Callback block when data is retrieved from server
      - temperature: Current temperature in Celcius
      - wind: Wind in m/s
      - measuredTime: Measured time in format: DD Mon YY HH:MI:SS
   
  */
  open class func getWeatherData(completion:@escaping (_ temperature:String, _ wind:String, _ measuredTime:String) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/en/frontmain.php?m=2").responseString(completionHandler: {
      response in
      
        switch response.result {
          
          case .failure(let error):
          
            debugPrint("Error: \(error)")
            debugPrint(response)
        
          case .success:
          
            do {
              // parse HTML file
              let document = try HTMLDocument(string: response.result.value!, encoding: String.Encoding.utf8)

              var temperature = ""
              var wind = ""
              var measuredTime = ""

              // get temperature
              if let val = document.css("td > b").first {
                temperature = val.stringValue
              }
              
              // get wind strenght
              let elements = document.css("td > b")
                if elements.count > 2 {
                  let w = elements[3]
                  print("getWind = \(w.stringValue)")
                  wind = w.stringValue
              }
              
              // get measured time
              if let val = document.css("td > small > i").first {
                print("\(val)")
                measuredTime = val.stringValue
              }
            
              completion(temperature, wind, measuredTime)
              
            } catch let error {
              debugPrint("Error: \(error)")
              debugPrint(response)
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
  open class func getCurrentImage(completion:@escaping (_ image:UIImage) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/webcam/uus/suur.jpg").responseImage { response in

      if let image = response.result.value {
        completion(image)
      }
    }
  }
}
