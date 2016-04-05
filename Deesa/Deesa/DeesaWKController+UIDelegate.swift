//
//  DeesaController+UIDelegate.swift
//  Deesa
//
//  Created by Dahan Hu on 1/21/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit

extension DeesaWKController: WKUIDelegate {
  
  public func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    // target="_blank"
    if let frame = navigationAction.targetFrame {
      if frame.mainFrame {
        webView.loadRequest(navigationAction.request)
      }
    }
    return nil
  }

  public func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
    let alert = UIAlertController(title: webView.URL?.host, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
      completionHandler()
    }))
    presentViewController(alert, animated: true, completion: nil)
  }
  
  public func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {
    let alert = UIAlertController(title: webView.URL?.host, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (_) -> Void in
      completionHandler(true)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (_) -> Void in
      completionHandler(false)
    }))
    presentViewController(alert, animated: true, completion: nil)
  }

  public func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String?) -> Void) {
    let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .Alert)
    alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
      textField.textColor = UIColor.redColor()
    }
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (_) -> Void in
      completionHandler(alert.textFields![0].text!)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (_) -> Void in
      completionHandler(nil)
    }))
    presentViewController(alert, animated: true, completion: nil)
  }
  
}
