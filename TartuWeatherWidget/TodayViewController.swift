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
  
  /// Temperature label
  @IBOutlet weak var temperatureLabel: UILabel!
  
  /// Wind label
  @IBOutlet weak var windLabel: UILabel!
  
  /// Measured time label
  @IBOutlet weak var measuredTimeLabel: UILabel!
  
  /// View model
  private var tartuWeatherViewModel: TartuWeatherViewModel = TartuWeatherViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func widgetPerformUpdate(completionHandler: @escaping ((NCUpdateResult) -> Void)) {
    tartuWeatherViewModel.getWeatherData {[weak self] in
      self?.temperatureLabel.text = $0.temperature
      self?.windLabel.text = $0.wind
      self?.measuredTimeLabel.text = $0.measuredTime
      completionHandler(.newData)
    }
    
  }
  
  @IBAction func openApp(_ sender: AnyObject) {
    self.extensionContext?.open(URL(string: "tartuweather://home")! as URL, completionHandler: nil)
  }
  
  func widgetMarginInsets( forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
    var defaultMarginInsets = defaultMarginInsets
    defaultMarginInsets.bottom = 20
    return defaultMarginInsets
  }
  
}
