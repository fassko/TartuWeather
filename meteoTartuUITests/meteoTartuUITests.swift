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
//    sleep(5)
    
    let app = XCUIApplication()
    
    app.navigationBars["meteo Tartu"].buttons["Refresh"].tap()
    
    app.statusBars.otherElements["5:07 PM"].tap()
    
    XCUIDevice.shared().orientation = .portrait
    app.children(matching: .window).element(boundBy: 6).children(matching: .other).element.tap()
    
    let scrollViewsQuery = app.scrollViews
    scrollViewsQuery.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeRight()
    scrollViewsQuery.otherElements.scrollViews.otherElements.buttons["Edit"].tap()
    app.tables.buttons["Insert meteo Tartu"].tap()
    app.navigationBars["UITableView"].buttons["Done"].tap()
    
    let page1Of2PageIndicator = app.pageIndicators["page 1 of 2"]
    page1Of2PageIndicator.swipeUp()
    XCUIDevice.shared().orientation = .portrait
    //    snapshot("Launch")
  }
    
}
