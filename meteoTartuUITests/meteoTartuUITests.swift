//
//  meteoTartuUITests.swift
//  meteoTartuUITests
//
//  Created by Kristaps Grinbergs on 06/11/2016.
//  Copyright © 2016 fassko. All rights reserved.
//


import XCTest

class meteoTartuUITests: XCTestCase {
        
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    
    let app = XCUIApplication()
    setupSnapshot(app)
    app.launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testLaunch() {
    sleep(5)
    
    snapshot("Launch")
    
    let app = XCUIApplication()
    
    app.navigationBars["meteo Tartu"].buttons["Refresh"].tap()
    
    let tempLabel = app.staticTexts["temp-label"]
    let windLabel = app.staticTexts["wind-label"]
    let measuredTimeLabel = app.staticTexts["measured-time-label"]
    
    XCTAssertNotNil(tempLabel.label)
    XCTAssert(tempLabel.label != "")

    XCTAssertNotNil(windLabel.label)
    XCTAssert(windLabel.label != "")
    
    XCTAssertNotNil(measuredTimeLabel.label)
    XCTAssert(measuredTimeLabel.label != "")
    
    let image = app.images["live-weather"]
    XCTAssert(image.exists)
  }
    
}
