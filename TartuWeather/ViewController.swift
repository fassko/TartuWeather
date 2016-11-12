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
  
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateWeather), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }
  
  
  func updateWeather() {
    WeatherAPI.getData(completion: {
      (temperature, wind, measuredTime) in
        self.temperatureLabel.text = temperature
        self.temperatureLabel.accessibilityLabel = temperature
      
        self.windLabel.text = wind
        self.windLabel.accessibilityLabel = wind
      
        self.measuredTimeLabel.text = measuredTime
        self.measuredTimeLabel.accessibilityLabel = measuredTime
    })
    
    WeatherAPI.getCurrentImage(completion: {
      (image) in
        self.currentImage.image = image
    })

  }
  
  
  @IBAction func refresh(sender: AnyObject) {
    updateWeather()
  }

}

