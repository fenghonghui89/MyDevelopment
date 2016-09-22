//
//  Starship.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

protocol FullyNamed{
  
  //协议属性
  var fullName:String{get}
  var getset:String{get set}
  
}

class Starship: FullyNamed {
  
  var prefix: String?
  var name: String
  init(name: String, prefix: String? = nil) {
    self.name = name
    self.prefix = prefix
  }
  
  //协议属性
  var fullName: String {
    
    let str1 = prefix == nil ? "":(prefix!+" ")
    return str1 + name;
    
  }
  
  var getset: String{
    
    get{
      print("get~")
      return name+" "+"getset";
    }
    
    set{
      print("set~")
      self.name = newValue
    }
  }
  
  
}
