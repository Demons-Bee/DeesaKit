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

func parse(json: AnyObject?) -> AnyObject? {
  guard let string = json as? String else { return nil }
  guard let jsonData = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else {
    return nil
  }
  guard let result = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: []) else {
    return nil
  }
  // TODO: 以下代码还需优化，需解决非纯JSON字符串的情况
  if let dic = result as? [NSObject:AnyObject] {
    var resDic = [NSObject:AnyObject]()
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

func toJSON(values: AnyObject?) -> String? {
  guard let values = values else { return nil }
  do {
    let jsonData = try NSJSONSerialization.dataWithJSONObject(values, options: [])
    if let jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding) {
      return jsonString
    }
  } catch let error as NSError {
    debugPrint(error.debugDescription)
    return nil
  }
  return nil
}

func registerUserPluginsForWebView(web: UIView, context: JSContext? = nil, bundle: NSBundle = NSBundle.mainBundle()) {
  guard let pluginsFile = NSBundle.mainBundle().URLForResource("UserPlugins", withExtension: "plist") else {
    debugPrint("UserPlugins.plist must be add to your main bundle! If you have any questions, please check out the demo project")
    return
  }
  guard let pluginsNames = NSArray(contentsOfURL: pluginsFile) else { return }
  for name in pluginsNames as! [String] {
    injectJS(name, forWebView: web, context: context, bundle: bundle)
  }
}

func injectJS(fileName: String, forWebView web: UIView, context: JSContext? = nil, bundle: NSBundle = NSBundle.mainBundle()) {
  guard let path = bundle.pathForResource(fileName, ofType: "js") else {
    debugPrint("Not found \(fileName).js file!")
    return
  }
  do {
    let js = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
    if web is WKWebView {
      (web as! WKWebView).evaluateJavaScript(js as String, completionHandler: nil)
    } else if web is UIWebView {
      context?.evaluateScript(js as String)
    }
  } catch let error as NSError {
    debugPrint(error.debugDescription)
  }
}