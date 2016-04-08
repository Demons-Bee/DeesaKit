//
//  DeesaActor.swift
//  Deesa
//
//  Created by Dahan Hu on 4/5/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

class DeesaActor: NSObject {

  var stage: Dictionary<NSObject,AnyObject>?
  var controller: DeesaController?
  var webView: UIView?
  
  init(stage: Dictionary<NSObject,AnyObject>?) {
    self.stage = stage
  }
  
  func act() {
    guard let dic = stage where !dic.isEmpty else { return }
    guard let className = dic["className"]?.description, funcName = dic["funcName"]?.description else { return }
    guard let clazz = NSClassFromString(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName")!.description + "." + className) as? DeesaPlugin.Type
      else {
        debugPrint("Not found! Class `\(className)`")
        return
    }
    let obj = clazz.init()
    let funcSelector = Selector(funcName + ":")
    if obj.respondsToSelector(funcSelector) {
      obj.controller = self.controller
      obj.webView = self.webView
      obj.callbackId = dic["callbackId"]?.integerValue
      obj.performSelector(funcSelector, withObject: DeesaArguments(data: dic["data"]))
    } else {
      debugPrint("Not found `\(funcSelector)` in `\(className)` class")
    }
  }
  
}
