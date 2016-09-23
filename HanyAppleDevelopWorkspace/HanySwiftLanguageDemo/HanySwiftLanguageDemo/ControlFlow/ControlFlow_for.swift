//
//  ControlFlow_for.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
// for 

import Foundation

func root_ControlFlow_for() {
  
}

//MARK: - <<< for循环 >>>
//MARK:对区间操作符进行循环
private func func1_1() {
  
  for index in 1...5
  {
    print("index:\(index)");
  }
  
  for index in 1..<10
  {
    print("index1:\(index)");
  }
  
  let base = 3;
  let power = 3;
  var answer = 1;
  for _ in 1...power
  {
    answer *= base;
  }
  print("\(answer)");
  
}

//MARK:枚举数组和字典中的元素
private func func1_2() {
  
  let arr = ["one","two",12] as [Any];
  for value in arr
  {
    print("\(value)");
  }
  
  
  let dic = ["k1":"v1",1:3] as [AnyHashable : Any];
  for (k,v) in dic
  {
    print("k:\(k),v:\(v)");
  }
  
}

//MARK:枚举字符串中的所有字符
private func func1_3() {
  
  for character in "Hello World".characters
  {
    print("<\(character)>");
  }
  
}

//MARK:条件增量for循环(循环标识如果在for外部定义则for内部不用加var)
private func func1_4() {
  
  for i in 0 ..< 3
  {
    print("i:\(i)");
  }
  
//  var ii = 0;
//  for ii = 0;ii<3;ii += 1
//  {
//    print("ii:\(ii)");
//  }
  
}
