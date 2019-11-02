//
//  meteoTartuUnitTests.swift
//  meteoTartuUnitTests
//
//  Created by Kristaps Grinbergs on 24/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import XCTest

@testable import TartuWeather
import TartuWeatherProvider

class MeteoTartuUnitTests: XCTestCase {

  func testCurrentWeatherData() {
    let viewModel = TartuWeatherViewModel()
    
    let expectation = self.expectation(description: "currentData")
    
    viewModel.getWeatherData { weatherData in
      XCTAssertNotNil(weatherData.temperature)
      XCTAssertNotNil(weatherData.wind)
      XCTAssertNotNil(weatherData.measuredTime)
      XCTAssertNotNil(weatherData.smallImage)
      XCTAssertNotNil(weatherData.largeImage)
      
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testHistoryToday() {
    runTestWithHistoryType(.today)
  }
  
  func testHistoryYesterday() {
    runTestWithHistoryType(.yesterday)
  }
  
  func runTestWithHistoryType(_ type: QueryDataType) {
    let historyViewModel = HistoryViewModel()
    
    let expectation = self.expectation(description: type.rawValue)
    
    historyViewModel.getChartData(type) { chartData in
      XCTAssertNotNil(chartData)
      
      guard let firstItem = chartData.first else {
        XCTFail("Failed to get first history item")
        return
      }
      
      XCTAssertNotNil(firstItem)
      
      expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
    
}
