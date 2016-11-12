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
    
    let app = XCUIApplication()
    
    app.navigationBars["meteo Tartu"].buttons["Refresh"].tap()
    
    let tempLabel = app.staticTexts.element(matching: .any, identifier: "temp-label")
    let windLabel = app.staticTexts.element(matching: .any, identifier: "wind-label")
    let measuredTimeLabel = app.staticTexts.element(matching: .any, identifier: "measured-time-label")
    
    XCTAssertNotNil(tempLabel.label)
    XCTAssert(tempLabel.label != "")

    XCTAssertNotNil(windLabel.label)
    XCTAssert(windLabel.label != "")
    
    XCTAssertNotNil(measuredTimeLabel.label)
    XCTAssert(measuredTimeLabel.label != "")
    
    let image = app.images["Live weather"]
    XCTAssert(image.exists)
  }
    
}
