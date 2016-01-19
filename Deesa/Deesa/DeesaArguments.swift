//
//  DeesaCommand.swift
//  Deesa
//
//  Created by Dahan Hu on 1/15/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import UIKit

public typealias DIC = Dictionary<NSObject,AnyObject>
public typealias ARR = Array<AnyObject>

public class DeesaArguments: NSObject {

  private var data: AnyObject?
  
  public override var description: String {
    guard let data = data else {
      return ""
    }
    return data.description
  }
  
  public var dictionaryValue: DIC? {
    if let res = data as? DIC {
      return res
    }
    if let res = parse(data) as? DIC {
      return res
    }
    return nil
  }
  
  public var arrayValue: ARR? {
    if let res = data as? ARR {
      return res
    }
    if let res = parse(data) as? ARR {
      return res
    }
    return nil
  }
  
  public var stringValue: String? {
    guard let res = data as? String else {
      return nil
    }
    return res
  }
  
  public var numberValue: NSNumber? {
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
