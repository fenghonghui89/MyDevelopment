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
  let generator:RandomNumberGenerator;//协议类型
  
  init(sides:Int,generator:RandomNumberGenerator){
    self.sides = sides;
    self.generator = generator;
  }
  
  func roll() ->Int {//RandomNumberGenerator协议要求
    return Int(generator.random() * Double(sides)) + 1
  }
}


extension Dice:TextRepresentable {
  
  func asText() -> String{
    return "A \(sides)-sided dice"
  }
}

