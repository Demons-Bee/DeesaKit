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

  @objc func alert(_ args: DeesaArguments) {
    DispatchQueue.main.async {
      UIAlertView(title: nil, message: args.description, delegate: nil, cancelButtonTitle: "OK").show()
    }
  }
  
  @objc func testCallback(_ args: DeesaArguments) {
    sendPluginResultWithValues(["success":"true"], status: PluginResultStatus.success)
  }
  
  @objc func testCommand(_ args: DeesaArguments) {
    sendPluginResultWithValues("错误回调,传入的参数为 `\(args.description)`", status: PluginResultStatus.error)
  }

}
