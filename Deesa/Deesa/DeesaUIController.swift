//
//  DeesaUIController.swift
//  Deesa
//
//  Created by Dahan Hu on 4/5/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import JavaScriptCore

open class DeesaUIController: DeesaController, UIWebViewDelegate {
  
  open fileprivate(set) var webView: UIWebView!
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    webView = UIWebView()
    view.addSubview(webView)
    view.sendSubview(toBack: webView)
    
    webView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-0-[web]-0-|",
        options: [],
        metrics: nil,
        views: ["web":webView])
    )
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-0-[web]-0-|",
        options: [],
        metrics: nil,
        views: ["web":webView])
    )
    
    configForWebView(webView)
    
    startLoad()
  }
  //
  //  open override func didReceiveMemoryWarning() {
  //    super.didReceiveMemoryWarning()
  //
  //    UserDefaults.standard.set(0, forKey: "WebKitCacheModelPreferenceKey")
  //    UserDefaults.standard.synchronize()
  //
  //    guard let navi = navigationController
  //      , !navi.viewControllers.isEmpty
  //        && webView != nil else {
  //          return
  //    }
  //
  //    if webView.superview != nil {
  //      webView.removeFromSuperview()
  //    }
  //    webView.loadHTMLString("", baseURL: nil)
  //    webView.stopLoading()
  //    webView.delegate = nil
  //    webView = nil
  //  }
  
  /** override this method must call super */
  open func configForWebView(_ webView: UIWebView) {
    webView.scrollView.delaysContentTouches = false
    webView.delegate = self
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
    webView.loadRequest(request as URLRequest)
  }
  
  /** override this method must call super */
  open func webViewDidFinishLoad(_ webView: UIWebView) {
    
    if let theURL = webView.request?.url, !webView.isLoading {
      debugPrint("⬆️\(Date().timeIntervalSince1970)⬆️ Finish load url: \(theURL)")
    }
  }
  
  open func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    if let theURL = webView.request?.url , !webView.isLoading {
      debugPrint("❗️\(Date().timeIntervalSince1970) Load url failed: \(theURL)")
    }
  }
  
  /** override this method must call super */
  open func webViewDidStartLoad(_ webView: UIWebView) {
    guard let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext else {return}
    let handler = DeesaMessageHandler(context: context, webView: webView, controller: self)
    context.setObject(handler, forKeyedSubscript: DeesaName as (NSCopying & NSObjectProtocol)!)
    context.exceptionHandler = { (context,exception) in
      print("exception\(String(describing: exception))")
    }
    injectJS(DeesaName, forWebView: webView, context: context, bundle: Bundle(for: DeesaController.self))
    registerUserPluginsForWebView(webView, context: context)
    
    if let theURL = URL, webView.isLoading {
      debugPrint("⬇️\(Date().timeIntervalSince1970)⬇️ Start load url: \(theURL.absoluteString)")
    }
  }
  
  open func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    return true
  }
  
}
