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
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController {

  @IBOutlet weak var dataTypeSegmentedControl: UISegmentedControl!

  @IBOutlet weak var chartView: LineChartView!
  
  let disposeBag = DisposeBag()
  
  let viewModel = HistoryViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpChart()
    
    viewModel.chartData.asObservable()
      .skipWhile({
        $0.isEmpty
      })
      .flatMap({ chartData -> Observable<[ChartDataEntry]> in
        Observable.just(chartData.map({
          ChartDataEntry(x: $0, y: $1)
        }))
      })
      .subscribe(onNext: { chartData in
        
        let line1 = LineChartDataSet(values: chartData, label: "Temperature")
        line1.axisDependency = .left
        line1.setColor(.black)
        line1.setCircleColor(#colorLiteral(red: 0.175999999, green: 0.3449999988, blue: 0.4979999959, alpha: 1))
        line1.lineWidth = 2
        line1.circleRadius = 3
        line1.mode = .horizontalBezier
        line1.highlightColor = .red
        line1.drawCircleHoleEnabled = false
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        self.chartView.data = data
        self.chartView.animate(xAxisDuration: 2)
      })
      .disposed(by: disposeBag)
  }
  
  func setUpChart() {
    chartView.rightAxis.enabled = false
    chartView.chartDescription?.enabled = false
    chartView.legend.enabled = false
    
    let marker = BalloonMarker(color: #colorLiteral(red: 0.9919999838, green: 0.7450000048, blue: 0.1570000052, alpha: 1),
                               font: .systemFont(ofSize: 12),
                               textColor: #colorLiteral(red: 0.175999999, green: 0.3449999988, blue: 0.4979999959, alpha: 1),
                               insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
    marker.chartView = chartView
    marker.minimumSize = CGSize(width: 80, height: 40)
    chartView.marker = marker
    
    let xAxis = chartView.xAxis
    xAxis.labelPosition = .topInside
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
    leftAxis.labelCount = 10
    leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
    leftAxis.labelPosition = .outsideChart
    leftAxis.spaceTop = 0.15
    leftAxis.spaceBottom = 0.15
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    dataTypeSegmentedControl.selectedSegmentIndex = 1
    
    dataTypeSegmentedControl.rx.value.asObservable()
      .flatMap({ selectedItem -> Observable<QueryDataType> in
        Observable.just(selectedItem == 0 ? .yesterday : .today)
      })
      .subscribe(onNext: {[weak self] value in
        self?.viewModel.updateChartData(value)
      })
      .disposed(by: disposeBag)
  }
}
