//
//  DeesaUIController.swift
//  Deesa
//
//  Created by Dahan Hu on 4/5/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import JavaScriptCore

public class DeesaUIController: DeesaController, UIWebViewDelegate {

  public private(set) var webView: UIWebView!
  
  public override func loadView() {
    super.loadView()
    webView = UIWebView(frame: self.view.bounds)
    configForWebView(webView)
    view = webView
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    startLoad()
  }
  
  /** override this method must call super */
  public func configForWebView(webView: UIWebView) {
    webView.scrollView.delaysContentTouches = false
    webView.delegate = self
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

  /** override this method must call super */
  public func webViewDidFinishLoad(webView: UIWebView) {
    guard let context = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext else {return}
    let handler = DeesaMessageHandler(context: context, webView: webView, controller: self)
    context.setObject(handler, forKeyedSubscript: DeesaName)
    context.exceptionHandler = { (context,exception) in
      print("exception\(exception)")
    }
    injectJS(DeesaName, forWebView: webView, context: context, bundle: NSBundle(forClass: DeesaController.self))
    registerUserPluginsForWebView(webView, context: context)
    
    if let theURL = webView.request?.URL where !webView.loading {
      debugPrint("Finish load url: \(theURL)")
    }
  }
  
  public func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    if let theURL = webView.request?.URL where !webView.loading {
      debugPrint("Load url failed: \(theURL)")
    }
  }
  
  public func webViewDidStartLoad(webView: UIWebView) {
    
  }
  
  public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    return true
  }
  
}
