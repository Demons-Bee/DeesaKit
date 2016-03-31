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
  
  public private(set) var webView: WKWebView!
  public private(set) var url: String!
  public private(set) var URL: NSURL?
  
  public convenience init(url: String) {
    let theURL = NSURL(string: url)
    self.init(URL: theURL)
    self.url = url
    self.URL = theURL
  }
  
  public convenience init(URL: NSURL?) {
    self.init(nibName: nil, bundle: nil)
    self.URL = URL
    self.url = URL?.absoluteString
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
    configConfiguration(config)
    
    let contentController = WKUserContentController()
    configUserContentController(contentController)
    
    config.userContentController = contentController
    webView = WKWebView(frame: self.view.bounds, configuration: config)
    configForWebView(webView)
    view = webView
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    startLoad()
    injectJS(DeesaName, bundle: NSBundle(forClass: DeesaController.self))
    registerUserPlugins()
  }
  /** override this method must call super */
  public func configForWebView(webView: WKWebView) {
    webView.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    webView.scrollView.delaysContentTouches = false
    webView.navigationDelegate = self
    webView.UIDelegate = self
  }
  /** override this method must call super */
  public func configUserContentController(controller: WKUserContentController) {
    controller.addScriptMessageHandler(self, name: DeesaName)
  }
  /** override this method must call super */
  public func configConfiguration(configuration: WKWebViewConfiguration) {
    configuration.processPool = DeesaController.pool
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
  
  /** override this method must call super */
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