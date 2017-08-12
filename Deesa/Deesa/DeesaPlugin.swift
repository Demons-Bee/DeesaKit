//
//  DeesaPlugin.swift
//  Deesa
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit

public enum PluginResultStatus {
  case success
  case error
}

open class DeesaPlugin: NSObject {
  
  open var controller: DeesaController!
  open var webView: UIView!
  open var callbackId: Int!
  
  public required override init() {}
  
  open func sendPluginResultWithValues(_ values: Any, status: PluginResultStatus) {
    var method = "DeesaOnSuccessCallback"
    var args = ""
    if status == PluginResultStatus.error {
      method = "DeesaOnErrorCallback"
    }
    if values is String {
      args = "'\(values as! String)'"
    } else if let json = toJSON(values) {
      args = json
    } else if let des = (values as AnyObject).description {
      args = "'\(des)'"
    }
    
    if callbackId == nil {
      debugPrint("callbackId missed!")
      return
    }
    
    // execute javascript on main thread
    if !Thread.isMainThread {
      performSelector(onMainThread: #selector(DeesaPlugin.executeJS(_:)), with: "\(method)(\(callbackId!), \(args))", waitUntilDone: false)
    } else {
      executeJS("\(method)(\(callbackId!), \(args))")
    }
  }
  
  //MARK:/*----------------------------------<excute javascript>---------------------------------------*/
  
  func executeJS(_ js: String) {
    if webView is UIWebView {
      (webView as! UIWebView).stringByEvaluatingJavaScript(from: js)
    } else if webView is WKWebView {
      (webView as! WKWebView).evaluateJavaScript(js, completionHandler: { (obj: Any?, error: Error?) in
        if let e = error {
          debugPrint(":::Deesa:::execute js `\(js)`--> error:\(e.localizedDescription)")
        }
      })
    }
  }
  
}
