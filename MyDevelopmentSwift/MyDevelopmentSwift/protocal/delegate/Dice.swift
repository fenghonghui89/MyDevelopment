//
//  File.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

class Dice {
  
  let sides:Int;
  let generator:protocol<RandomNumberGenerator>;//协议类型
//  let generator:RandomNumberGenerator;//或者这样
  
  init(sides:Int,generator:RandomNumberGenerator){
    self.sides = sides;
    self.generator = generator;
  }
  
  //RandomNumberGenerator协议方法
  func roll() ->Int {
    return Int(generator.random() * Double(sides)) + 1
  }
}

//给类扩展协议
extension Dice:TextRepresentable {
  
  func asText() -> String{
    return "A \(sides)-sided dice"
  }
}

