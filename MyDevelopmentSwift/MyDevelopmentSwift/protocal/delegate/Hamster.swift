//
//  Hamster.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//
/*
 如果一个类型已经符合协议的所有要求，但尚未指定其采用的协议，你就可以使用空扩展声明它采用协议。
 */

import Foundation

class Hamster {
  
  var name:String
  
  init(name:String){
    self.name = name;
  }
  
  var textualDescription: String {
    return "A hamster named \(name)"
  }
  
}

//使用空扩展声明一个符合要求的类采用协议
extension Hamster:TextRepresentable{}