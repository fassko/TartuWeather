//
//  meteoTartuUITests.swift
//  meteoTartuUITests
//
//  Created by Kristaps Grinbergs on 06/11/2016.
//  Copyright © 2016 fassko. All rights reserved.
//

import XCTest

class MeteoTartuUITests: XCTestCase {
        
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testLaunch() {
    
    let app = XCUIApplication()
    setupSnapshot(app)
    app.launch()
    
    sleep(1)
    
    app.navigationBars["meteo Tartu"].buttons["Refresh"].tap()

    let tempLabel = app.staticTexts["temp-label"]
    let windLabel = app.staticTexts["wind-label"]
    let measuredTimeLabel = app.staticTexts["measured-time-label"]
    let image = app.images["live-weather"]

    XCTAssertTrue(tempLabel.waitForExistence(timeout: 1))
    XCTAssertTrue(windLabel.waitForExistence(timeout: 1))
    XCTAssertTrue(measuredTimeLabel.waitForExistence(timeout: 1))
    XCTAssertTrue(image.waitForExistence(timeout: 1))

    XCTAssertNotNil(tempLabel.label)
    XCTAssert(tempLabel.label != "")

    XCTAssertNotNil(windLabel.label)
    XCTAssert(windLabel.label != "")

    XCTAssertNotNil(measuredTimeLabel.label)
    XCTAssert(measuredTimeLabel.label != "")

    snapshot("AppLaunched")

    image.tap()

    sleep(1)

    snapshot("LiveImage")
    
    app.buttons["Close"].tap()
    
    sleep(1)
    
    app.tabBars.buttons["History"].tap()
    
    snapshot("History_Today")
    
    sleep(1)

    app.segmentedControls.buttons["Yesterday"].tap()
    
    snapshot("History_Yesterday")
    
    sleep(1)
    
  }
    
}
