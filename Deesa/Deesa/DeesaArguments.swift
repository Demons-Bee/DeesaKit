//
//  DeesaCommand.swift
//  Deesa
//
//  Created by Dahan Hu on 1/15/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

public typealias DeesaDic = Dictionary<AnyHashable,AnyObject>
public typealias DeesaArr = Array<AnyObject>

open class DeesaArguments: NSObject {

  open subscript(key: String) -> AnyObject? {
    get {
      guard let dict = dictionaryValue else { return nil }
      return dict[key]
    }
  }
  
  open subscript(index: Int) -> AnyObject? {
    get {
      guard let arr = arrayValue else { return nil }
      if index > arr.count { return nil }
      return arr[index]
    }
  }
  
  fileprivate var data: AnyObject?
  
  open override var description: String {
    guard let data = data else {
      return ""
    }
    return data.description
  }
  
  open var dictionaryValue: DeesaDic? {
    if let res = data as? DeesaDic {
      return res
    }
    if let res = parse(data) as? DeesaDic {
      return res
    }
    return nil
  }
  
  open var arrayValue: DeesaArr? {
    if let res = data as? DeesaArr {
      return res
    }
    if let res = parse(data) as? DeesaArr {
      return res
    }
    return nil
  }
  
  open var stringValue: String? {
    guard let res = data as? String else {
      return nil
    }
    return res
  }
  
  open var numberValue: NSNumber? {
    guard let res = data as? NSNumber else {
      return nil
    }
    return res
  }
  
  convenience init(data: AnyObject?) {
    self.init()
    self.data = data
  }
  
}
