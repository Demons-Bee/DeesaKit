//
//  HostApp.swift
//  DeesaExample
//
//  Created by Dahan Hu on 1/13/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import Deesa

class ConsolePlugin: DeesaPlugin {
  
  func log(_ args: DeesaArguments) {
    //    print("______Deesa log begin______\n")
    //    if let dic = args.dictionaryValue {
    //      print(dic)
    //      print("下标语法取key=deviceInfo, value=\(args["deviceInfo"])")
    //    }
    //    if let array = args.arrayValue {
    //      print(array)
    //      print("下标语法取第0个元素值为: \(args[0])")
    //    }
    //    if let string = args.stringValue {
    //      print(string)
    //    }
    //    if let number = args.numberValue {
    //      print(number)
    //      print("下标语法取第0个元素值为: \(args[0])")
    //    }
    //    print("\n______Deesa log ended______")
//    let a = ((args["key1"] as! [AnyHashable:AnyObject])["bbb"] as! [AnyObject])[1]
//    let b = args["key"] as! String
//    print(b)
//    print(a)
    print(args.description)
    //    print(args["key1"])
  }
  
}
