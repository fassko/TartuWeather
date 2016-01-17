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
  @IBOutlet weak var measuredTimeLabel: UILabel!
        
  override func viewDidLoad() {
    super.viewDidLoad()
    
    WeatherAPI.getData({
      (temperature, wind, measuredTime) in
        self.temperatureLabel.text = temperature
        self.windLabel.text = wind
        self.measuredTimeLabel.text = measuredTime
    })
  }

  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    WeatherAPI.getData({
      (temperature, wind, measuredTime) in
        self.temperatureLabel.text = temperature
        self.windLabel.text = wind
        self.measuredTimeLabel.text = measuredTime
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
