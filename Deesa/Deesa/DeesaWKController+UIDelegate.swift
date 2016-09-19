//
//  DeesaController+UIDelegate.swift
//  Deesa
//
//  Created by Dahan Hu on 1/21/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit

extension DeesaWKController: WKUIDelegate {
  
  public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    // target="_blank"
    if let frame = navigationAction.targetFrame {
      if frame.isMainFrame {
        webView.load(navigationAction.request)
      }
    }
    return nil
  }

  public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
    let alert = UIAlertController(title: webView.url?.host, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) -> Void in
      completionHandler()
    }))
    present(alert, animated: true, completion: nil)
  }
  
  public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    let alert = UIAlertController(title: webView.url?.host, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
      completionHandler(true)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) -> Void in
      completionHandler(false)
    }))
    present(alert, animated: true, completion: nil)
  }

  public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .alert)
    alert.addTextField { (textField: UITextField) -> Void in
      textField.textColor = UIColor.red
    }
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
      completionHandler(alert.textFields![0].text!)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) -> Void in
      completionHandler(nil)
    }))
    present(alert, animated: true, completion: nil)
  }
  
}
