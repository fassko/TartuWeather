//
//  meteoTartuUnitTests.swift
//  meteoTartuUnitTests
//
//  Created by Kristaps Grinbergs on 24/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import XCTest

import TartuWeatherProvider

class MeteoTartuUnitTests: XCTestCase {

  func testCurrentWeatherData() {
    let viewModel = TartuWeatherViewModel()

    var temperature: String?
    var wind: String?
    var measuredTime: String?
    var smallImage: String?
    var largeImage: String?
    
    let expectation = self.expectation(description: "currentData")
    
//    viewModel.smallImage.asObservable()
//      .skipWhile({
//        $0 == nil
//      })
//      .take(1)
//      .subscribe(onNext: { _ in
//        temperature = viewModel.temperature.value
//        wind = viewModel.wind.value
//
//        measuredTime = viewModel.measuredTime.value
//        smallImage = viewModel.smallImage.value
//        largeImage = viewModel.largeImage.value
//
//        expectation.fulfill()
//      })
//      .disposed(by: disposeBag)
    
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertNotNil(temperature)
    XCTAssertNotNil(wind)
    XCTAssertNotNil(measuredTime)
    XCTAssertNotNil(smallImage)
    XCTAssertNotNil(largeImage)
  }
  
  func testHistoryToday() {
    runTestWithHistoryType(.today)
  }
  
  func testHistoryYesterday() {
    runTestWithHistoryType(.yesterday)
  }
  
  func runTestWithHistoryType(_ type: QueryDataType) {
    let historyViewModel = HistoryViewModel()
    var chartData: [HistoryViewModel.ChartDataItem]?
    
    let expectation = self.expectation(description: type.rawValue)
    
//    historyViewModel.updateChartData(type)
    
//    historyViewModel.chartData
//      .asObservable()
//      .skipWhile({ $0.isEmpty })
//      .subscribe(onNext: { data in
//        chartData = data
//        expectation.fulfill()
//      })
//      .disposed(by: disposeBag)
    
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertNotNil(chartData)
    
    guard let firstItem = chartData?.first else {
      XCTFail("Failed to get first history item")
      return
    }
    
    XCTAssertNotNil(firstItem)
  }
    
}
