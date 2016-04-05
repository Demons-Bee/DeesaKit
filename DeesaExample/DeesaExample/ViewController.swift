//
//  ViewController.swift
//  DeesaExample
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import Deesa

class ViewController: UIViewController {

  @IBOutlet weak var segment: UISegmentedControl!
  var wkController: DeesaWKController!
  var uiController: DeesaUIController!

  @IBAction func segmentSwitchAction(sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      if uiController == nil {
        uiController = DeesaUIController(URL: NSBundle.mainBundle().URLForResource("test", withExtension: "html"))
        uiController.view.frame = CGRect(x: 0, y: 64, width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds)-64)
        view.addSubview(uiController.view)
        addChildViewController(uiController)
        uiController.didMoveToParentViewController(self)
        
        wkController?.removeFromParentViewController()
        wkController = nil
      }
    } else {
      if wkController == nil {
        wkController = DeesaWKController(URL: NSBundle.mainBundle().URLForResource("test", withExtension: "html"))
        wkController.view.frame = CGRect(x: 0, y: 64, width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds)-64)
        view.addSubview(wkController.view)
        addChildViewController(wkController)
        wkController.didMoveToParentViewController(self)
        
        uiController?.removeFromParentViewController()
        uiController = nil
      }
    }
  }
}
