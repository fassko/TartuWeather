//
//  ComplicationController.swift
//  WatchApp Extension
//
//  Created by Kristaps Grinbergs on 25/10/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import WatchKit

// Keys for accessing the complicationData dictionary.
//let ComplicationCurrentEntry = "ComplicationCurrentEntry"
//let ComplicationTextData = "ComplicationTextData"
//let ComplicationShortTextData = "ComplicationShortTextData"

class ComplicationController: NSObject, CLKComplicationDataSource {
  func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    handler([.backward, .forward])
  }
  
  func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  // MARK: - Timeline Population
  
  func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
    
    print("----------------->")
    print(complication.family)
    
    switch complication.family {
    case .utilitarianSmall:
      let template = CLKComplicationTemplateUtilitarianSmallRingText()
      template.textProvider = CLKSimpleTextProvider(text: "18")
      template.fillFraction = 0.6
      template.ringStyle = .closed
      handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
    default:
      return
    }
  }
  
  func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    // Call the handler with the timeline entries prior to the given date
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    // Call the handler with the timeline entries after to the given date
    handler([])
  }
  
  // MARK: - Placeholder Templates
  
  func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    // This method will be called once per supported complication, and the results will be cached
    handler(nil)
  }

  
//  func getCurrentTimelineEntryForComplication(complication: CLKComplication,
//                                            withHandler handler: ((CLKComplicationTemplate?) -> Void)) {
//
//    print("Update compilation")
//
//  var template: CLKComplicationTemplate?
//  switch complication.family {
//  case .circularSmall:
//    let circularSmall = CLKComplicationTemplateCircularSmallRingText()
//    circularSmall.textProvider = CLKSimpleTextProvider(text: "18")
//    circularSmall.fillFraction = 0.75
//    circularSmall.ringStyle = .closed
//    template = circularSmall
//    handler(circularSmall)
//
//  case .modularSmall:
//    let modularSmallTemplate =
//      CLKComplicationTemplateModularSmallRingText()
//    modularSmallTemplate.textProvider =
//      CLKSimpleTextProvider(text: "18.0")
//    modularSmallTemplate.fillFraction = 0.75
//    modularSmallTemplate.ringStyle = CLKComplicationRingStyle.closed
//    template = modularSmallTemplate
//    handler(template)
//
//
////  case .modularLarge:
////    <#code#>
//  case .utilitarianSmall:
//    let ttemlp = CLKComplicationTemplateUtilitarianSmallRingText()
//    ttemlp.textProvider = CLKSimpleTextProvider(text: "18")
//    ttemlp.fillFraction = 0.6
//    ttemlp.ringStyle = .closed
//    handler(ttemlp)
//
//
////  case .utilitarianSmallFlat:
////    <#code#>
////  case .utilitarianLarge:
////    <#code#>
////  case .circularSmall:
////    <#code#>
////  case .extraLarge:
////    <#code#>
////  case .graphicCorner:
////    <#code#>
////  case .graphicBezel:
////    <#code#>
////  case .graphicCircular:
////    <#code#>
////  case .graphicRectangular:
////    <#code#>
//
//  default:
//    return
//  }
//
////  // Get the complication data from the extension delegate.
////  let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
////  var data : Dictionary = myDelegate.myComplicationData[ComplicationCurrentEntry]!
////
////  var entry : CLKComplicationTimelineEntry?
////  let now = NSDate()
////
////  // Create the template and timeline entry.
////  if complication.family == .modularSmall {
////    let longText = data[ComplicationTextData]
////    let shortText = data[ComplicationShortTextData]
////
////    let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
////    textTemplate.textProvider = CLKSimpleTextProvider(text: longText, shortText: shortText)
////
////    // Create the entry.
////    entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: textTemplate)
////  }
////  else {
////    // ...configure entries for other complication families.
////  }
////
////  // Pass the timeline entry back to ClockKit.
////  handler(entry)
//}
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    handler(Date(timeIntervalSinceNow: 60))
  }

}
