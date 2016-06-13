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
        view.addSubview(uiController.view)
        uiController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints(["H:|-0-[ui]-0-|","V:|-64-[ui]-0-|"].flatMap{NSLayoutConstraint.constraintsWithVisualFormat($0, options: [], metrics: nil, views: ["ui":self.uiController.view])})
        addChildViewController(uiController)
        uiController.didMoveToParentViewController(self)
        
        wkController?.removeFromParentViewController()
        wkController = nil
      }
    } else {
      if wkController == nil {
        wkController = DeesaWKController(URL: NSBundle.mainBundle().URLForResource("test", withExtension: "html"))
        view.addSubview(wkController.view)
        wkController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints(["H:|-0-[wk]-0-|","V:|-64-[wk]-0-|"].flatMap{NSLayoutConstraint.constraintsWithVisualFormat($0, options: [], metrics: nil, views: ["wk":self.wkController.view])})
        addChildViewController(wkController)
        wkController.didMoveToParentViewController(self)
        
        uiController?.removeFromParentViewController()
        uiController = nil
      }
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    automaticallyAdjustsScrollViewInsets = false
    segment.selectedSegmentIndex = 0
    segmentSwitchAction(segment)
  }

}
