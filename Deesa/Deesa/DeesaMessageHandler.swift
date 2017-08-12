//
//  DeesaMessageHandler.swift
//  Deesa
//
//  Created by Dahan Hu on 4/5/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc
protocol MessageHandlerExport: JSExport {
  func postMessage(_ args: Dictionary<AnyHashable,Any>)
}

@objc
class DeesaMessageHandler: NSObject, MessageHandlerExport {
  
  weak var context: JSContext!
  weak var webView: UIWebView!
  weak var controller: DeesaController!
  
  init(context: JSContext?, webView: UIWebView?, controller: DeesaController?) {
    self.context = context
    self.webView = webView
    self.controller = controller
  }
  
  func postMessage(_ dic: Dictionary<AnyHashable,Any>) {
    let actor = DeesaActor(stage: dic)
    actor.controller = controller
    actor.webView = webView
    DispatchQueue.main.async {
      actor.act()
    }
  }
  
}
