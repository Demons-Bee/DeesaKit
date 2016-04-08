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

  func alert(args: DeesaArguments) {
    dispatch_async(dispatch_get_main_queue()) {
      UIAlertView(title: nil, message: args.description, delegate: nil, cancelButtonTitle: "OK").show()
    }
  }
  
  func testCallback(args: DeesaArguments) {
    sendPluginResultWithValues(["success":"true"], status: PluginResultStatus.Success)
  }
  
  func testCommand(args: DeesaArguments) {
    sendPluginResultWithValues("错误回调", status: PluginResultStatus.Error)
  }
  
}
