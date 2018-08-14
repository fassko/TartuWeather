//
//  AppDelegate.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
    
    Fabric.with([Crashlytics.self])
    UINavigationBar.appearance().barStyle = .black
    return true
  }

}
