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

  @IBOutlet weak var dataTypeSegmentedControl: UISegmentedControl!

  @IBOutlet weak var chartView: LineChartView!
  
  let viewModel = HistoryViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpChart()
  }
  
  func setUpChart() {
    chartView.rightAxis.enabled = false
    chartView.chartDescription?.enabled = false
    chartView.legend.enabled = false
    
    let marker = BalloonMarker(color: Constants.blueColor,
                               font: .systemFont(ofSize: 12),
                               textColor: Constants.chartLabelColor,
                               insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
    marker.chartView = chartView
    marker.minimumSize = CGSize(width: 80, height: 40)
    chartView.marker = marker
    
    let xAxis = chartView.xAxis
    xAxis.labelPosition = .topInside
    xAxis.labelTextColor = Constants.chartLabelColor
    xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
    xAxis.drawAxisLineEnabled = false
    xAxis.drawGridLinesEnabled = true
    xAxis.centerAxisLabelsEnabled = true
    xAxis.granularity = 5 * 60
    xAxis.labelCount = 24
    xAxis.valueFormatter = DateValueFormatter()
    
    let leftAxisFormatter = NumberFormatter()
    leftAxisFormatter.minimumFractionDigits = 0
    leftAxisFormatter.maximumFractionDigits = 2
    leftAxisFormatter.negativeSuffix = " °C"
    leftAxisFormatter.positiveSuffix = " °C"
    
    let leftAxis = chartView.leftAxis
    leftAxis.labelFont = .systemFont(ofSize: 10)
    leftAxis.labelTextColor = Constants.chartLabelColor
    leftAxis.labelCount = 10
    leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
    leftAxis.labelPosition = .outsideChart
    leftAxis.spaceTop = 0.15
    leftAxis.spaceBottom = 0.15
  }
  
  @IBAction func historyTypeChanged(_ sender: UISegmentedControl) {
    let dataType: QueryDataType = sender.selectedSegmentIndex == 0 ? .yesterday : .today
    updateData(with: dataType)
  }
  
  private func updateData(with dataType: QueryDataType) {
    
    viewModel.getChartData(dataType) { chartData in
      guard !chartData.isEmpty else { return }
      
      let chartDataEntries: [ChartDataEntry] = chartData.map {
        ChartDataEntry(x: $0, y: $1)
      }
      
      let line1 = LineChartDataSet(entries: chartDataEntries, label: "Temperature")
      line1.axisDependency = .left
      line1.setColor(Constants.chartLineColor)
      line1.setCircleColor(Constants.blueColor)
      line1.lineWidth = 2
      line1.circleRadius = 3
      line1.mode = .horizontalBezier
      line1.highlightColor = .red
      line1.drawCircleHoleEnabled = false

      let data = LineChartData()
      data.addDataSet(line1)

      self.chartView.data = data
      self.chartView.animate(xAxisDuration: 2)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    updateData(with: .today)
  }
}
