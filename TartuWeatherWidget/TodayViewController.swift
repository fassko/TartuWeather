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
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
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
