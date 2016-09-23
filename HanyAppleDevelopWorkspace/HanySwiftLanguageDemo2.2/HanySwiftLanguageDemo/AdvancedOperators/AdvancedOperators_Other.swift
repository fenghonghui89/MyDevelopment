//
//  AdvancedOperators_Other.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//溢出运算符

import Foundation

func root_AdvancedOperators_Other() {
  
}

//MARK:- 溢出运算符 &
//MARK:值的上溢出&+ 下溢出&-
private func func_OverflowOperators() {
  
  //无符号int 上溢出
  var willOverflow = UInt8.max //255
  willOverflow = willOverflow &+ 1 //0
  print(willOverflow)
  
  //无符号int 下溢出
  var willUnderflow = UInt8.min //0
  willUnderflow = willUnderflow &- 1 //255
  print(willUnderflow)
  
  //有符号int 下溢出
  var signedUnderflow = Int8.min //-128
  signedUnderflow = signedUnderflow &- 1 //127
  print(signedUnderflow)
  
  //用&强制输出溢出值
  let x3:Int = 112233;
  let y3:Int = 112233 &* x3;
  print(y3);
}