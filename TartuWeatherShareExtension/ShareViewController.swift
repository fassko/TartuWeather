//
//  ShareViewController.swift
//  TartuWeatherShareExtension
//
//  Created by Kristaps Grinbergs on 17/09/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
  
  override func isContentValid() -> Bool {
    return true
  }
  
  override func didSelectPost() {
    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }
  
  override func configurationItems() -> [Any]! {
    return []
  }
}
