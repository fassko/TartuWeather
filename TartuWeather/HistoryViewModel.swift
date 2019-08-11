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
  public var chartData = BehaviorRelay<[ChartDataItem]>(value: [])
  
  /// Dispose bag
  fileprivate let disposeBag = DisposeBag()
  
  /// Update chart data
  func updateChartData(_ dataType: QueryDataType) {
    TartuWeatherProvider.getArchiveData(dataType) {
      self.convertHistoryResult(result: $0)
    }
  }
  
  /**
    Convert history data result
   
    - Parameters:
      - result: History data result
  */
  fileprivate func convertHistoryResult(result: TartuWeatherResult<[QueryData], TartuWeatherError>) {
    switch result {
    case let .success(value):
      self.chartData.accept(value.compactMap {
        guard let temperature = Double($0.temperature),
          let date = $0.measuredDate?.timeIntervalSince1970 else {
          return nil
        }
        
        return ChartDataItem(date, temperature)
      })
      
    case let .failure(error):
      print("Can't get history data \(error)")
    }
  }
}
