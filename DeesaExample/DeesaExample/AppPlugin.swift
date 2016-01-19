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
    let alert = UIAlertController(title: nil, message: args.description, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    controller?.presentViewController(alert, animated: true, completion: nil)
  }
  
  func testCallback(args: DeesaArguments) {
    sendPluginResultWithValues(["success":"true"], status: PluginResultStatus.Success)
  }
  
  func testCommand(args: DeesaArguments) {
    sendPluginResultWithValues("错误回调", status: PluginResultStatus.Error)
  }
  
}
