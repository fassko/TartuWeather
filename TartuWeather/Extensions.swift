//
//  Extensions.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 25/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation

extension Double {

  /**
    Round double to decimal places
   
    - Parameters:
      - places: Round to decimal places
   
    - Returns: Rounded double
  */
  func rounded(toPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
