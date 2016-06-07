//
//  DeesaController.swift
//  Deesa
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

public let DeesaName = "Deesa"

public class DeesaController: UIViewController {
  
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
  
}