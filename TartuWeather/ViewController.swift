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
  @IBOutlet weak var measuredTimeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateWeather()
  
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateWeather", name: UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  
  func updateWeather() {
    WeatherAPI.getData({
      (temperature, wind, measuredTime) in
        self.temperatureLabel.text = temperature
        self.windLabel.text = wind
        self.measuredTimeLabel.text = measuredTime
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

