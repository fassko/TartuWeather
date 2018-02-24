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
    
    XCUIDevice.shared.orientation = .portrait
    
    sleep(1)

    // MARK: - Now

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

    snapshot("Now")

    image.tap()

    sleep(1)

    snapshot("LiveImage")

    app.buttons["Close"].tap()

    sleep(1)
    
    XCUIDevice.shared.orientation = .landscapeLeft
    
    sleep(1)
    
    snapshot("Now_Landscape")
    
    XCUIDevice.shared.orientation = .portrait
    
    sleep(1)
    
    // MARK: - History
    app.tabBars.buttons["History"].tap()
    
    sleep(3)

    snapshot("History_Today")

    app.segmentedControls.buttons["Yesterday"].tap()
    
    sleep(3)

    snapshot("History_Yesterday")
    
    XCUIDevice.shared.orientation = .landscapeLeft
    
    sleep(1)
    
    snapshot("History_Yesterday_Landscape")
    
    app.segmentedControls.buttons["Today"].tap()
    
    sleep(3)
    
    snapshot("History_Today_Landscape")
  }
}
