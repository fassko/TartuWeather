//
//  HistoryViewModel.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 23/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation

import Charts
import TartuWeatherProvider

struct HistoryViewModel {
  
  typealias ChartDataItem = (x: Double, y: Double)
  
  func getChartData(_ dataType: QueryDataType, _ completion: @escaping ([ChartDataItem]) -> Void) {
    TartuWeatherProvider.getArchiveData(dataType) { result in
      switch result {
      case let .success(value):
        var chartData = [ChartDataItem]()
        chartData = value.compactMap {
          guard let temperature = Double($0.temperature),
            let date = $0.measuredDate?.timeIntervalSince1970 else {
            return nil
          }
          
          return ChartDataItem(date, temperature)
        }
        
        if !chartData.isEmpty {
          completion(chartData)
        }
        
      case let .failure(error):
        print("Can't get history data \(error)")
      }
    }
  }
}
