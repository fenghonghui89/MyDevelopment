//
//  File.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

protocol TextRepresentable {
  
  var textualDescription: String { get }

}

class Dice {
  
  let sides:Int;
  let generator:RandomNumberGenerator;//协议类型
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

//用扩展给类添加协议实现
extension Dice:TextRepresentable {
  
  var textualDescription: String {
    return "A \(sides)-sided dice"
  }

}

