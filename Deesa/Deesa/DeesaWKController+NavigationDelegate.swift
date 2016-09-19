//
//  DeesaController+NavigationDelegate.swift
//  Deesa
//
//  Created by Dahan Hu on 1/21/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit

extension DeesaWKController: WKNavigationDelegate {
  
  public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    decisionHandler(.allow)
  }

  public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    decisionHandler(.allow)
  }

  public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
  }

  public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    
  }

  public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    debugPrint(error.localizedDescription)
  }

  public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    
  }

  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    if let theURL = URL , !webView.isLoading {
      debugPrint("Finish load url: \(theURL)")
    }
  }

  public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    debugPrint(error.localizedDescription)
  }

  public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
    completionHandler(.useCredential, cred)
  }
  
}
