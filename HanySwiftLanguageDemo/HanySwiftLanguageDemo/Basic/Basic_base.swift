//
//  Basic_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//基础

import Foundation


func root_Basic_base(){
  

}


//MARK:常量及变量 定义 初始化 赋值 动态推导
private func kl_init(){

//    var v;//不指定类型就要初始化，否则非法
  var v:Int;//指定类型就可以不初始化
  var v1 = 20; v1 = 30;
  var v2:Int; v2 = 20;
  var v3:Int = 20; v3 = 30;
  
//    let l;//非法，同上
  let l:Int;
  let l1 = 20; //l1 = 20;//常量不能改变值
  let l2:Int; l2 = 20;
  let l3:Int = 20;//l3 = 30;//常量不能改变值
  
}

//MARK:数值可读性 中文变量/常量名
private func kl_readNum(){

  let productid = 1_000_000.000_000_1;
  let 你好 = "你们";
  print("ID:\(productid) \n Name:\(你好)");
}

//MARK:int范围
private func kl_typeScope(){

  let min = INT64_MAX;
  let max = Int64.max
  print("wo shi \(min) \n \(max)");
}

//MARK:类型转换
private func kl_typeChange(){
  
  let dv2:Double = Double(123);
  let ii = Int(12.3);
  let i:float_t = 1;
  print("\(dv2)  \(ii) \(i)");

}

//MARK:类型别名 typealias
private func kl_typealias(){

  typealias AudioSample = UInt16
  let maxAmplitudeFound = AudioSample.min
  print(maxAmplitudeFound)
}