//
//  ViewController.swift
//  DeesaExample
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import WebKit
import Deesa

class ViewController: DeesaController {

  override func viewDidLoad() {
    super.viewDidLoad()
//    url = "http://192.168.1.21:8020/html5app/pages/main.html"
    let request = NSURLRequest(URL: NSBundle.mainBundle().URLForResource("test", withExtension: "html")!)
    webView.loadRequest(request)
  }

}
