//
//  HistoryViewModel.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 23/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import TartuWeatherProvider

/// History screen viewModel
struct HistoryViewModel {
  
  /// Chart data item
  typealias ChartDataItem = (x: Double, y: Double)
  
  /// Chart data
  public var chartData = Variable<[ChartDataItem]>([])
  
  /// Dispose bag
  fileprivate let disposeBag = DisposeBag()
  
  /// Update chart data
  func updateChartData(_ dataType: QueryDataType) {
    TartuWeatherProvider.getArchiveData(dataType) { result in
      switch result {
      case let .success(value):
        self.chartData.value = value.map({
          ChartDataItem(($0.measuredDate?.timeIntervalSince1970)!, Double($0.temperature)!)
        })
        
      case let .failure(error):
        print("Can't get history data \(error)")
      }
    }
  }
}
