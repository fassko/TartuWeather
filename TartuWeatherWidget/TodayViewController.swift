//
//  TodayViewController.swift
//  TartuWeatherWidget
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
        
  override func viewDidLoad() {
    super.viewDidLoad()
    
    WeatherAPI.getTemperature({
      (temperature) in
        self.temperatureLabel.text = temperature
    })
    
    WeatherAPI.getWind({
      (wind) in
        self.windLabel.text = wind
    })
  }

  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
  
    WeatherAPI.getTemperature({
      (temperature) in
        self.temperatureLabel.text = temperature
        completionHandler(NCUpdateResult.NewData)
    })
    
    WeatherAPI.getWind({
      (wind) in
        self.windLabel.text = wind
        completionHandler(NCUpdateResult.NewData)
    })
  }
  
  
  @IBAction func openApp(sender: AnyObject) {
    self.extensionContext?.openURL(NSURL(string:"tartuweather://home")!, completionHandler: nil)
  }
  
  func widgetMarginInsetsForProposedMarginInsets(var defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
    defaultMarginInsets.bottom = 20;
    return defaultMarginInsets
  }
  
}
