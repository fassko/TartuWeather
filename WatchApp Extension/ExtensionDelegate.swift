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
    for task in backgroundTasks {
      switch task {
      case let backgroundTask as WKApplicationRefreshBackgroundTask:
        backgroundTask.setTaskCompleted()
      case let snapshotTask as WKSnapshotRefreshBackgroundTask:
        snapshotTask.setTaskCompleted(restoredDefaultState: true,
                                      estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
      case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
        connectivityTask.setTaskCompleted()
      case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
        urlSessionTask.setTaskCompleted()
      default:
        task.setTaskCompleted()
      }
    }
  }

}
