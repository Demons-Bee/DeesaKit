//
//  MyURLProtocol.swift
//  AgricultureOnline
//
//  Created by Dahan Hu on 2/29/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

class ReplaceRemoteJSProtocol: NSURLProtocol {
  
  override class func canInitWithRequest(request: NSURLRequest) -> Bool {
    if NSURLProtocol.propertyForKey("ReplaceRemoteJSProtocolHandledKey", inRequest: request) != nil {
      return false
    }
    if request.URL!.absoluteString.containsString("app.js") { //这里只是做了简单的判断，需要根据实际情况做处理
      return true
    }
    return false
  }
  
  override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
    return request
  }
  
  override class func requestIsCacheEquivalent(a: NSURLRequest, toRequest b: NSURLRequest) -> Bool {
    return super.requestIsCacheEquivalent(a, toRequest: b)
  }
  
  override func startLoading() {
    
    let newRequest = request.mutableCopy() as! NSMutableURLRequest
    if let URL = getLocalWebSourcePathWithUrl(newRequest.URL!.absoluteString),
      let data = NSData(contentsOfURL: URL) {
      let response = NSURLResponse(URL: newRequest.URL!, MIMEType: "application/javascript", expectedContentLength: data.length, textEncodingName: nil)
      client?.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
      client?.URLProtocol(self, didLoadData: data)
      client?.URLProtocolDidFinishLoading(self)
      
      NSURLProtocol.setProperty(true, forKey: "ReplaceRemoteJSProtocolHandledKey", inRequest: newRequest)
    } else {
      client?.URLProtocol(self, didFailWithError: NSError(domain: "FileNotFound", code: 404, userInfo: nil))
    }
  }
  
  override func stopLoading() {
    
  }
  
  private func getLocalWebSourcePathWithUrl(absoluteUrl: String) -> NSURL? {
    var targetUrl = absoluteUrl as NSString
    let location = (absoluteUrl as NSString).rangeOfString("?").location
    if location != NSNotFound {
      targetUrl = targetUrl.substringToIndex(location)
    }
    let localWebSourceFileName = targetUrl.lastPathComponent
    if let URL = NSBundle.mainBundle().URLForResource(localWebSourceFileName, withExtension: nil) {
        print("replaced with local resource name = \(localWebSourceFileName), URL = \(URL)")
      return URL
    }
    return nil
  }
  
}