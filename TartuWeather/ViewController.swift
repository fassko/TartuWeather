//
//  ViewController.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var currentImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateWeather()
  
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateWeather", name: UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  
  func updateWeather() {
    WeatherAPI.getTemperature({
      (temperature) in
        self.temperatureLabel.text = temperature
    })
    
    WeatherAPI.getWind({
      (wind) in
        self.windLabel.text = wind
    })
    
    WeatherAPI.getCurrentImage({
      (image) in
        self.currentImage.image = image
    })
    
  }
  
  
  @IBAction func refresh(sender: AnyObject) {
    updateWeather()
  }

}

