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
    print("args.dictionaryValue:  \(args.dictionaryValue)")
    print("args.arrayValue:       \(args.arrayValue)")
    print("args.stringValue:      \(args.stringValue)")
    print("args.numberValue:      \(args.numberValue)")
    print("--------------------------")
  }
}