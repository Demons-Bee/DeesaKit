//
//  MyURLProtocol.swift
//  AgricultureOnline
//
//  Created by Dahan Hu on 2/29/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

class ReplaceRemoteJSProtocol: URLProtocol {
  
  override class func canInit(with request: URLRequest) -> Bool {
    if URLProtocol.property(forKey: "ReplaceRemoteJSProtocolHandledKey", in: request) != nil {
      return false
    }
    if request.url!.absoluteString.contains("app.js") { //这里只是做了简单的判断，需要根据实际情况做处理
      return true
    }
    return false
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
    return super.requestIsCacheEquivalent(a, to: b)
  }
  
  override func startLoading() {
    
    let newRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
    if let URL = getLocalWebSourcePathWithUrl(newRequest.url!.absoluteString),
      let data = try? Data(contentsOf: URL) {
      let response = URLResponse(url: newRequest.url!, mimeType: "application/javascript", expectedContentLength: data.count, textEncodingName: nil)
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
      client?.urlProtocolDidFinishLoading(self)
      
      URLProtocol.setProperty(true, forKey: "ReplaceRemoteJSProtocolHandledKey", in: newRequest)
    } else {
      client?.urlProtocol(self, didFailWithError: NSError(domain: "FileNotFound", code: 404, userInfo: nil))
    }
  }
  
  override func stopLoading() {
    
  }
  
  fileprivate func getLocalWebSourcePathWithUrl(_ absoluteUrl: String) -> URL? {
    var targetUrl = absoluteUrl as NSString
    let location = (absoluteUrl as NSString).range(of: "?").location
    if location != NSNotFound {
      targetUrl = targetUrl.substring(to: location) as NSString
    }
    let localWebSourceFileName = targetUrl.lastPathComponent
    if let URL = Bundle.main.url(forResource: localWebSourceFileName, withExtension: nil) {
        print("replaced with local resource name = \(localWebSourceFileName), URL = \(URL)")
      return URL
    }
    return nil
  }
  
}
