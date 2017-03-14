//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Kristaps Grinbergs on 05/02/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import WatchKit
import Foundation

import TartuWeatherProvider


class InterfaceController: WKInterfaceController {
  
  /// Current image
  @IBOutlet var currentImage: WKInterfaceImage!
  
  /// Temperature label
  @IBOutlet var tempLabel: WKInterfaceLabel!
  
  /// Wind label
  @IBOutlet var windLabel: WKInterfaceLabel!
  
  /// Measured label
  @IBOutlet var measuredLabel: WKInterfaceLabel!

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    self.loadTemperatureData()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  /**
    Reload data
  */
  @IBAction func reloadData() {
    WKInterfaceDevice().play(.notification)
    self.loadTemperatureData()
  }
  
  /**
    Load temperature data
  */
  private func loadTemperatureData() {

    TartuWeatherProvider.getWeatherData(completion: {data, error in
    
      guard let temp = data?.temperature, let wind = data?.wind, let measured = data?.measuredTime else {
        return
      }
      
      self.tempLabel.setText(temp)
      self.windLabel.setText(wind)
      self.measuredLabel.setText(measured)
    })
    
    TartuWeatherProvider.getCurrentImage(completion: {image in
      self.currentImage.setImage(image)
    })
  }
}
