//
//  TodayViewController.swift
//  TartuWeatherWidget
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import NotificationCenter

import TartuWeatherProvider

class TodayViewController: UIViewController, NCWidgetProviding {
        
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var measuredTimeLabel: UILabel!
        
  override func viewDidLoad() {
    super.viewDidLoad()
    
    TartuWeatherProvider.getWeatherData(completion: {
      (temperature, wind, measuredTime) in
        self.temperatureLabel.text = temperature
        self.windLabel.text = wind
        self.measuredTimeLabel.text = measuredTime
    })
  }

  func widgetPerformUpdateWithCompletionHandler(completionHandler: @escaping ((NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    TartuWeatherProvider.getWeatherData(completion: {
      (temperature, wind, measuredTime) in
        self.temperatureLabel.text = temperature
        self.windLabel.text = wind
        self.measuredTimeLabel.text = measuredTime
        completionHandler(NCUpdateResult.newData)
    })
    
  }
  
  
  @IBAction func openApp(sender: AnyObject) {
    self.extensionContext?.open(NSURL(string:"tartuweather://home")! as URL, completionHandler: nil)
  }
  
  func widgetMarginInsetsForProposedMarginInsets( defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
    var defaultMarginInsets = defaultMarginInsets
    defaultMarginInsets.bottom = 20;
    return defaultMarginInsets
  }
  
}
