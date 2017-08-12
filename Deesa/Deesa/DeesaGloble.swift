//
//  DeesaGloble.swift
//  Deesa
//
//  Created by Dahan Hu on 1/15/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import Foundation
import WebKit
import JavaScriptCore

func parse(_ json: Any?) -> Any? {
  guard let string = json as? String else { return nil }
  guard let jsonData = string.data(using: .utf8, allowLossyConversion: false) else {
    return nil
  }
  guard let result = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
    return nil
  }
  // TODO: 以下代码还需优化，需解决非纯JSON字符串的情况
  if let dic = result as? [AnyHashable: Any] {
    var resDic = [AnyHashable: Any]()
    for (k,v) in dic {
      resDic[k] = parse(v)
    }
    if !resDic.isEmpty {
      return resDic
    }
  }
  if let res = result as? [AnyObject] {
    let resArr = res.flatMap {
      parse($0)
    }
    if !resArr.isEmpty {
      return resArr
    }
  }
  return result
}

func toJSON(_ values: Any?) -> String? {
  guard let values = values else { return nil }
  do {
    let jsonData = try JSONSerialization.data(withJSONObject: values, options: [])
    if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
      return jsonString
    }
  } catch let error as NSError {
    debugPrint(error.debugDescription)
    return nil
  }
  return nil
}

func registerUserPluginsForWebView(_ web: UIView, context: JSContext? = nil, bundle: Bundle = Bundle.main) {
  guard let pluginsFile = Bundle.main.url(forResource: "UserPlugins", withExtension: "plist") else {
    debugPrint("UserPlugins.plist must be add to your main bundle! If you have any questions, please check out the demo project")
    return
  }
  guard let pluginsNames = NSArray(contentsOf: pluginsFile) else { return }
  for name in pluginsNames as! [String] {
    injectJS(name, forWebView: web, context: context, bundle: bundle)
  }
}

func injectJS(_ fileName: String, forWebView web: UIView, context: JSContext? = nil, bundle: Bundle = Bundle.main) {
  guard let path = bundle.path(forResource: fileName, ofType: "js") else {
    debugPrint("Not found \(fileName).js file!")
    return
  }
  do {
    let js = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
    if web is WKWebView {
      (web as! WKWebView).evaluateJavaScript(js as String, completionHandler: nil)
    } else if web is UIWebView {
      _ = context?.evaluateScript(js as String)
    }
  } catch let error as NSError {
    debugPrint(error.debugDescription)
  }
}
