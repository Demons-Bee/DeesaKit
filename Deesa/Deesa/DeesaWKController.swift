//
//  DeesaWKController.swift
//  Deesa
//
//  Created by Dahan Hu on 4/5/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import WebKit

open class DeesaWKController: DeesaController, WKScriptMessageHandler {
  
  /** share cookie in all WKWebView, singleton */
  open static let pool = WKProcessPool()
  
  open fileprivate(set) var webView: WKWebView!
  
  open override func loadView() {
    super.loadView()
    let config = WKWebViewConfiguration()
    configConfiguration(config)
    
    let contentController = WKUserContentController()
    configUserContentController(contentController)
    
    config.userContentController = contentController
    webView = WKWebView(frame: self.view.bounds, configuration: config)
    configForWebView(webView)
    view = webView
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    startLoad()
    injectJS(DeesaName, forWebView: webView, bundle: Bundle(for: DeesaController.self))
    registerUserPluginsForWebView(webView)
  }
  
  /** override this method must call super */
  open func configForWebView(_ webView: WKWebView) {
    webView.scrollView.delaysContentTouches = false
    webView.navigationDelegate = self
    webView.uiDelegate = self
  }
  
  /** override this method must call super */
  open func configUserContentController(_ controller: WKUserContentController) {
    controller.add(self, name: DeesaName)
  }
  
  /** override this method must call super */
  open func configConfiguration(_ configuration: WKWebViewConfiguration) {
    configuration.processPool = DeesaWKController.pool
  }
  
  /** override this method to customizing the request
   DeesaController will call this method before webView start loadRequest */
  open func configRequest(_ request: NSMutableURLRequest) {}
  
  func startLoad() {
    guard let theURL = URL else {
      debugPrint("Invalidated URL!")
      return
    }
    let request = NSMutableURLRequest(url: theURL as URL)
    configRequest(request)
    webView.load(request as URLRequest)
  }
  
  //MARK:/*----------------------------------<WKScriptMessageHandler>---------------------------------------*/
  
  /** override this method must call super */
  open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    if DeesaName != message.name { return }
    guard let dic = message.body as? Dictionary<AnyHashable,Any> else { return }
    let actor = DeesaActor(stage: dic)
    actor.controller = self
    actor.webView = webView
    actor.act()
  }
  
}
