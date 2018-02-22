//
//  HistoryViewController.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 22/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import UIKit

import Charts
import TartuWeatherProvider

class HistoryViewController: UIViewController {

  @IBOutlet weak var chartView: LineChartView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let ll2 = ChartLimitLine(limit: 40, label: "Lower Limit")
    ll2.lineWidth = 4
    ll2.lineDashLengths = [5,5]
    ll2.labelPosition = .rightBottom
    ll2.valueFont = .systemFont(ofSize: 10)
    
    TartuWeatherProvider.getArchiveData(.today) { result in
      switch result {
      case let .success(value):
        var lineChartEntry = [ChartDataEntry]()
        
        value.enumerated().forEach { index, data in
          if let temperature = Double(data.temperature) {
            let value = ChartDataEntry(x: Double(index), y: temperature)
            lineChartEntry.append(value)
          }
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Temperature")
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.addDataSet(line1)
        self.chartView.data = data
        self.chartView.setNeedsDisplay()
        
      case let .failure(error):
        print("Can't get history data \(error)")
      }
    }
    
    
  }
  

}
