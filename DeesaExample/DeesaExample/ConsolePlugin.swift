//
//  Console.swift
//  BlackHawk
//
//  Created by leqicheng on 15/8/28.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
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
  }
  
}