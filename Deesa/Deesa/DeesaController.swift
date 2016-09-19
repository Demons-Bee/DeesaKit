//
//  DeesaController.swift
//  Deesa
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

public let DeesaName = "Deesa"

open class DeesaController: UIViewController {
  
  open fileprivate(set) var url: String!
  open fileprivate(set) var URL: Foundation.URL?
  
  public convenience init(url: String) {
    let theURL = Foundation.URL(string: url)
    self.init(URL: theURL)
    self.url = url
    self.URL = theURL
  }
  
  public convenience init(URL: Foundation.URL?) {
    self.init(nibName: nil, bundle: nil)
    self.URL = URL
    self.url = URL?.absoluteString
  }
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
