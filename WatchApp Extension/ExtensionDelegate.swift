//
//  ExtensionDelegate.swift
//  WatchApp Extension
//
//  Created by Kristaps Grinbergs on 05/02/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

  func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
    // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
    for task in backgroundTasks {
      // Use a switch statement to check the task type
      switch task {
      case let backgroundTask as WKApplicationRefreshBackgroundTask:
        // Be sure to complete the background task once you’re done.
        backgroundTask.setTaskCompleted()
      case let snapshotTask as WKSnapshotRefreshBackgroundTask:
        // Snapshot tasks have a unique completion call, make sure to set your expiration date
        snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
      case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
        // Be sure to complete the connectivity task once you’re done.
        connectivityTask.setTaskCompleted()
      case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
        // Be sure to complete the URL session task once you’re done.
        urlSessionTask.setTaskCompleted()
      default:
        // make sure to complete unhandled task types
        task.setTaskCompleted()
      }
    }
  }

}
