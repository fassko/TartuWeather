//
//  LiveImage.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 13/09/2017.
//

import Foundation

public struct LiveImage {

  /// Small image URL
  public var small: String
  
  /// Large image URL
  public var large: String
  
  /**
    Init function
   
    - Parameters:
      - small: Small image URL
      - large: Large image URL
  */
  init(small:String, large:String) {
    self.small = small
    self.large = large
  }
}
