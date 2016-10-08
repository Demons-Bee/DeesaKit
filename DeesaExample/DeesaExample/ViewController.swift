//
//  ViewController.swift
//  DeesaExample
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import Deesa
import WebKit

class WKController: DeesaWKController {
  override func configUserContentController(_ controller: WKUserContentController) {
    super.configUserContentController(controller)
    
    /** 由于WKWebView不使用URLLoadSystem，所以如果想加入类似AppReady等事件，需要手动注入该功能的js */
    let filePath = Bundle.main.path(forResource: "app", ofType: "js")!
    let source = try! String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    let script = WKUserScript.init(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
    
    controller.addUserScript(script)
  }
}

class ViewController: UIViewController {

  @IBOutlet weak var segment: UISegmentedControl!
  var wkController: WKController!
  var uiController: DeesaUIController!

  @IBAction func segmentSwitchAction(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      if uiController == nil {
        uiController = DeesaUIController(URL: Bundle.main.url(forResource: "test", withExtension: "html"))
        view.addSubview(uiController.view)
        uiController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(["H:|-0-[ui]-0-|","V:|-64-[ui]-0-|"].flatMap{NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: ["ui":self.uiController.view])})
        addChildViewController(uiController)
        uiController.didMove(toParentViewController: self)
        
        wkController?.removeFromParentViewController()
        wkController = nil
      }
    } else {
      if wkController == nil {
        wkController = WKController(URL: Bundle.main.url(forResource: "test", withExtension: "html"))
        view.addSubview(wkController.view)
        
        wkController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(["H:|-0-[wk]-0-|","V:|-64-[wk]-0-|"].flatMap{NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: ["wk":self.wkController.view])})
        addChildViewController(wkController)
        wkController.didMove(toParentViewController: self)
        
        uiController?.removeFromParentViewController()
        uiController = nil
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    automaticallyAdjustsScrollViewInsets = false
    segment.selectedSegmentIndex = 0
    segmentSwitchAction(segment)
  }

}
