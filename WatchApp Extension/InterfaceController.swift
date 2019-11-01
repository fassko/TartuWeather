//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Kristaps Grinbergs on 05/02/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import WatchKit
import Foundation

import Kingfisher

class InterfaceController: WKInterfaceController {
  
  /// Current image
  @IBOutlet var currentImage: WKInterfaceImage!
  
  /// Temperature label
  @IBOutlet var tempLabel: WKInterfaceLabel!
  
  /// Wind label
  @IBOutlet var windLabel: WKInterfaceLabel!
  
  /// Measured label
  @IBOutlet var measuredLabel: WKInterfaceLabel!
  
  /// View model
  private var tartuWeatherViewModel = TartuWeatherViewModel()
  
  private var timer: Timer?

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  fileprivate func updateData() {
    tartuWeatherViewModel.getWeatherData {[weak self] weatherData in
      self?.tempLabel.setText(weatherData.temperature)
      self?.windLabel.setText(weatherData.wind)
      self?.measuredLabel.setText(weatherData.measuredTime)
      
      let url = URL(string: weatherData.smallImage)!
      self?.currentImage.kf.setImage(with: url, options: [.forceRefresh])
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    updateData()
    
    timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) {[weak self] _ in
      self?.updateData()
    }
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  /**
    Reload data when button pressed
  */
  @IBAction func reloadData() {
    reload()
  }
  
  @IBAction func reloadFromMenu() {
    reload()
  }
  
  /**
   Relod data and create notification
  **/
  fileprivate func reload() {
    WKInterfaceDevice().play(.notification)
    updateData()
  }
  
}
