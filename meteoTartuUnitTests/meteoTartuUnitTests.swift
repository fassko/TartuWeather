//
//  meteoTartuUnitTests.swift
//  meteoTartuUnitTests
//
//  Created by Kristaps Grinbergs on 06/11/2016.
//  Copyright © 2016 fassko. All rights reserved.
//

import Quick
import Nimble

class MeteoTartuTests : QuickSpec {
  override func spec() {
    describe("meteo Tartu tests") {
      it("should get data from web") {
      
        var temp = ""
        var wind = ""
        var lastUpdated = ""
        
        waitUntil(action: {
          done in
            WeatherAPI.getData(completion: {
              (temperature, w, measuredTime) in
                temp = temperature
                wind = w
                lastUpdated = measuredTime
              
                done()
            })
        })
        
        expect(temp).toEventuallyNot(beEmpty())
        expect(wind).toEventuallyNot(beEmpty())
        expect(lastUpdated).toEventuallyNot(beEmpty())
      }

      it("should get image") {
        var image:UIImage?
        
        waitUntil(action: {
          done in
            WeatherAPI.getCurrentImage(completion: {
              i in
                image = i
                done()
            })
        })
        
        expect(image).toEventuallyNot(beNil())
      }
    }
  }
}
