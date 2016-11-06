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
import AlamoFuzi

class WeatherAPI {
  
  class func getData(completion:@escaping (_ temperature:String, _ wind:String, _ measuredTime:String) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/en/frontmain.php?m=2").responseHTML(completionHandler: {
      response in
      
        switch response.result {
          
          case .failure(let error):
          
            debugPrint("Error: \(error)")
            debugPrint(response)
        
          case .success(let document):
          
            var temperature = ""
            var wind = ""
            var measuredTime = ""
            
            if let val = document.css("td > b").first {
              print("\(val)")
              temperature = val.stringValue
            }
            
            let elements = document.css("td > b")
              if elements.count > 2 {
                let w = elements[3]
                print("getWind = \(w.stringValue)")
                wind = w.stringValue
            }
            
            if let val = document.css("td > small > i").first {
              print("\(val)")
              measuredTime = val.stringValue
            }
          
            completion(temperature, wind, measuredTime)
        }
    })
  }
  
  class func getCurrentImage(completion:@escaping (_ image:UIImage) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/webcam/praegu/small.jpg").responseImage { response in

      if let image = response.result.value {
        completion(image)
      }
    }
  }

}
