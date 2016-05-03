//
//  LinearCongruentialGenerator.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//
/*
 模拟随机数生成
 */

import Foundation

class LinearCongruentialGenerator: RandomNumberGenerator {//协议类型
  
  var lastRandom = 42.0
  let m = 139968.0
  let a = 3877.0
  let c = 29573.0
  
  //RandomNumberGenerator协议方法
  func random() -> Double {
    lastRandom = ((lastRandom * a + c) % m)
    return lastRandom / m
  }
}