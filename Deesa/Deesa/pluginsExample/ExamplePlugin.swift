//
//  PagePlugin.swift
//  WebTest
//
//  Created by Dahan Hu on 1/19/16.
//  Copyright © 2016 tangyq. All rights reserved.
//

import UIKit
//import Deesa

class ExamplePlugin: DeesaPlugin {

  func setStatusBar(args: DeesaArguments) {
    print(args)
  }
  
  func setTitleBar(args: DeesaArguments) {
    print(args)
    controller.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: controller, action: nil), animated: true)
  }
  
  func setTabBar(args: DeesaArguments) {
    print(args)
  }
  
  func closeWindow(args: DeesaArguments) {
    controller.navigationController?.popViewControllerAnimated(true)
  }
  
}
