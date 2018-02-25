//
//  meteoTartuUITests.swift
//  meteoTartuUITests
//
//  Created by Kristaps Grinbergs on 06/11/2016.
//  Copyright © 2016 fassko. All rights reserved.
//

import XCTest

class MeteoTartuUITests: XCTestCase {

  var counter = 0
        
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

    now()
    history()
  }
  
  fileprivate func now() {
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

    takeScreenShot("Now")

    image.tap()

    sleep(1)

    takeScreenShot("LiveImage")

    app.buttons["Close"].tap()

    sleep(1)
    
    XCUIDevice.shared.orientation = .landscapeLeft
    
    sleep(1)
    
    takeScreenShot("Now_Landscape")
    
    XCUIDevice.shared.orientation = .portrait
    
    sleep(1)
  }
  
  fileprivate func history() {
    app.tabBars.buttons["History"].tap()
    
    sleep(3)

    takeScreenShot("History_Today")

    app.segmentedControls.buttons["Yesterday"].tap()
    
    sleep(3)

    takeScreenShot("History_Yesterday")
    
    XCUIDevice.shared.orientation = .landscapeLeft
    
    sleep(1)
    
    takeScreenShot("History_Yesterday_Landscape")
    
    app.segmentedControls.buttons["Today"].tap()
    
    sleep(3)
    
    takeScreenShot("History_Today_Landscape")
  }
 
  fileprivate func takeScreenShot(_ name: String) {
    snapshot("\(String(format: "%02d", counter))_\(name)")
    counter += 1
  }
}
