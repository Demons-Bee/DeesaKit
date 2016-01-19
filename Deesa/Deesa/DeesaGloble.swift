//
//  DeesaGloble.swift
//  Deesa
//
//  Created by Dahan Hu on 1/15/16.
//  Copyright © 2016 AppHeader. All rights reserved.
//

import Foundation

func parse(json: AnyObject?) -> AnyObject? {
  guard let jsonData = (json as? String)?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else {
    debugPrint("invalidated json format")
    return nil
  }
  guard let result = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: []) else {
    debugPrint("invalidated json format")
    return nil
  }
  return result
}

func toJSON(values: AnyObject?) -> String? {
  guard let values = values else { return nil }
  do {
    let jsonData = try NSJSONSerialization.dataWithJSONObject(values, options: [])
    if let jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding) {
      return jsonString
    }
  } catch let error as NSError {
    debugPrint(error.debugDescription)
    return nil
  }
  return nil
}