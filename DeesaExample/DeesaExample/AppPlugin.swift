//
//  HostApp.swift
//  DeesaExample
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import Deesa

class AppPlugin: DeesaPlugin {

  func alert(_ args: DeesaArguments) {
    DispatchQueue.main.async {
      UIAlertView(title: nil, message: args.description, delegate: nil, cancelButtonTitle: "OK").show()
    }
  }
  
  func testCallback(_ args: DeesaArguments) {
    sendPluginResultWithValues(["success":"true"] as AnyObject, status: PluginResultStatus.success)
  }
  
  func testCommand(_ args: DeesaArguments) {
    sendPluginResultWithValues("错误回调,传入的参数为 `\(args.description)`" as AnyObject, status: PluginResultStatus.error)
  }
  
}
