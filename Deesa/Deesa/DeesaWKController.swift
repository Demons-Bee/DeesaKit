//
//  DeesaWKController.swift
//  Deesa
//
//  Created by Dahan Hu on 4/5/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import WebKit

public class DeesaWKController: DeesaController, WKScriptMessageHandler {

  /** share cookie in all WKWebView, singleton */
  public static let pool = WKProcessPool()
  
  public private(set) var webView: WKWebView!
  
  public override func loadView() {
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
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    startLoad()
    injectJS(DeesaName, forWebView: webView, bundle: NSBundle(forClass: DeesaController.self))
    registerUserPluginsForWebView(webView)
  }
  
  /** override this method must call super */
  public func configForWebView(webView: WKWebView) {
    webView.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    webView.scrollView.delaysContentTouches = false
    webView.navigationDelegate = self
    webView.UIDelegate = self
  }
  
  /** override this method must call super */
  public func configUserContentController(controller: WKUserContentController) {
    controller.addScriptMessageHandler(self, name: DeesaName)
  }
  
  /** override this method must call super */
  public func configConfiguration(configuration: WKWebViewConfiguration) {
    configuration.processPool = DeesaWKController.pool
  }
  
  /** override this method to customizing the request
   DeesaController will call this method before webView start loadRequest */
  public func configRequest(request: NSMutableURLRequest) {}
  
  func startLoad() {
    guard let theURL = URL else {
      debugPrint("Invalidated URL!")
      return
    }
    let request = NSMutableURLRequest(URL: theURL)
    configRequest(request)
    webView.loadRequest(request)
  }
  
  //MARK:/*----------------------------------<WKScriptMessageHandler>---------------------------------------*/
  
  /** override this method must call super */
  public func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
    if DeesaName != message.name { return }
    guard let dic = message.body as? Dictionary<NSObject,AnyObject> else { return }
    let actor = DeesaActor(stage: dic)
    actor.controller = self
    actor.webView = webView
    actor.act()
  }

}
