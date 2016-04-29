//
//  Starship.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

protocol FullyNamed{
  
  //属性要求
  var fullName:String{get}
  var getset:String{get set}
  
  //方法要求
  func funcRequire() -> Double
  
  //mutating方法要求
  mutating func toggle();
}

class Starship: FullyNamed {
  
  var prefix: String?
  var name: String
  init(name: String, prefix: String? = nil) {
    self.name = name
    self.prefix = prefix
  }
  
  //属性要求
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
  
  
  //方法要求
  func funcRequire() -> Double {
    return 0.11;
  }
  
  //mutating方法要求
  enum OnOffSwitch {
    case on,off
  }
  
  var state:OnOffSwitch = OnOffSwitch.off
  
  func toggle() {
    switch self.state{
    case .on:
      self.state = .off;
    case .off:
      self.state = .on;
    }
  }
}
