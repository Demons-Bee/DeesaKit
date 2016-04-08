//
//  HostApp.swift
//  DeesaExample
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import Deesa

class ConsolePlugin: DeesaPlugin {
  
  func log(args: DeesaArguments) {
    print("______Deesa log begin______\n")
    if let dic = args.dictionaryValue {
      print(dic)
    }
    if let array = args.arrayValue {
      print(array)
    }
    if let string = args.stringValue {
      print(string)
    }
    if let number = args.numberValue {
      print(number)
    }
    print("\n______Deesa log ended______")
    print(args.argumentAtIndex(0))
    print(args.argumentForKey("deviceInfo"))
  }
  
}