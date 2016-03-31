//
//  DeesaPlugin.swift
//  Deesa
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit

public enum PluginResultStatus {
  case Success
  case Error
}

public class DeesaPlugin: NSObject {
  
  public var controller: DeesaController!
  public var webView: WKWebView!
  public var callbackId: Int!
  
  public required override init() {}
  
  public func sendPluginResultWithValues(values: AnyObject, status: PluginResultStatus) {
    var method = "DeesaOnSuccessCallback"
    var args = ""
    if status == PluginResultStatus.Error {
      method = "DeesaOnErrorCallback"
    }
    if values is String {
      args = values as! String
    } else if let json = toJSON(values) {
      args = json
    } else if let des = values.description {
      args = des
    }
    excuteJS("\(method)(\(callbackId), '\(args)')")
  }
  
  //MARK:/*----------------------------------<excute javascript>---------------------------------------*/
  
  func excuteJS(js: String, funcName: String = #function) {
    webView.evaluateJavaScript(js, completionHandler: { (obj: AnyObject?, error: NSError?) -> Void in
      if let e = error {
        debugPrint("\(funcName)--> error:\(e.debugDescription)")
      }
    })
  }
  
}
