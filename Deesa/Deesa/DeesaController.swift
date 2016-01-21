//
//  DeesaController.swift
//  Deesa
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit
import WebKit

public let DeesaName = "Deesa"

public class DeesaController: UIViewController, WKScriptMessageHandler {
  /** share cookie in all WKWebView, singleton */
  public static let pool = WKProcessPool()
  
  public var webView: WKWebView!
  var URL: NSURL?
  
  public convenience init(url: String) {
    self.init(URL: NSURL(string: url))
  }
  
  public convenience init(URL: NSURL?) {
    self.init(nibName: nil, bundle: nil)
    self.URL = URL
  }
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public override func loadView() {
    super.loadView()
    let config = WKWebViewConfiguration()
    config.processPool = DeesaController.pool
    config.userContentController.addScriptMessageHandler(self, name: DeesaName)
    webView = WKWebView(frame: self.view.bounds, configuration: config)
    webView.navigationDelegate = self
    webView.UIDelegate = self
    view = webView
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    startLoad()
    injectJS(DeesaName, bundle: NSBundle(forClass: DeesaController.self))
    registerUserPlugins()
  }
  
  func startLoad() {
    guard let theURL = URL else {
      debugPrint("Invalidated URL!")
      return
    }
    webView.loadRequest(NSURLRequest(URL: theURL))
    debugPrint("Finish load url: \(theURL)")
  }
  
  func registerUserPlugins() {
    guard let pluginsFile = NSBundle.mainBundle().URLForResource("UserPlugins", withExtension: "plist") else {
      debugPrint("UserPlugins.plist must be add to your main bundle!")
      return
    }
    guard let pluginsNames = NSArray(contentsOfURL: pluginsFile) else { return }
    for name in pluginsNames as! [String] {
      injectJS(name)
    }
  }
  
  func injectJS(fileName: String, bundle: NSBundle = NSBundle.mainBundle()) {
    guard let path = bundle.pathForResource(fileName, ofType: "js") else {
      debugPrint("Not found \(fileName).js file!")
      return
    }
    do {
      let js = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
      webView.evaluateJavaScript(js as String, completionHandler: nil)
    } catch let error as NSError {
      debugPrint(error.debugDescription)
    }
  }
  
  //MARK:/*----------------------------------<WKScriptMessageHandler>---------------------------------------*/
  
  public func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
    if DeesaName != message.name { return }
    guard let dic = message.body as? NSDictionary else { return }
    guard let className = dic["className"]?.description, funcName = dic["funcName"]?.description else { return }
    guard let clazz = NSClassFromString(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName")!.description + "." + className) as? DeesaPlugin.Type
      else {
        debugPrint("Not found! Class `\(className)`")
        return
    }
    let obj = clazz.init()
    let funcSelector = Selector(funcName + ":")
    if obj.respondsToSelector(funcSelector) {
      obj.controller = self
      obj.webView = self.webView
      obj.callbackId = dic["taskId"]?.integerValue
      obj.performSelector(funcSelector, withObject: DeesaArguments(data: dic["data"]))
    } else {
      debugPrint("Not found `\(funcSelector)` in `\(className)` class")
    }
  }
  
}