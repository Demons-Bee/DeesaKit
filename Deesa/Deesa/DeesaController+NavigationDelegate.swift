//
//  DeesaController+NavigationDelegate.swift
//  Deesa
//
//  Created by Dahan Hu on 1/21/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit

extension DeesaController: WKNavigationDelegate {
  
  public func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
    decisionHandler(.Allow)
  }

  public func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
    decisionHandler(.Allow)
  }

  public func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
  }

  public func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    
  }

  public func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
    
  }

  public func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    
  }

  public func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    
  }

  public func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
    debugPrint(error.debugDescription)
  }

  public func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
    let cred = NSURLCredential.init(forTrust: challenge.protectionSpace.serverTrust!)
    completionHandler(.UseCredential, cred)
  }
  
}