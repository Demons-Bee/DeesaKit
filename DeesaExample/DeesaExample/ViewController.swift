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
        wkController = DeesaWKController(URL: Bundle.main.url(forResource: "test", withExtension: "html"))
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
