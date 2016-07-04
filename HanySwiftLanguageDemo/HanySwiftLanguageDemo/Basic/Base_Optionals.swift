//
//  Base_Optionals.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//可选类型

import Foundation

func root_Base_Optionals() {
  
}


//MARK:作用：处理值可能缺失的情况 当值为nil不中断
/*
 C 和 OC 中并没有可选这个概念。最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回nil，nil表示“缺少一个合法的对象”。
 然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，OC 方法一般会返回一个特殊值（比如NSNotFound）来暗示值缺失。这种方法假设方法的调用者知道并记得对特殊值进行判断。
 然而，Swift 的可选可以让你暗示任意类型的值缺失，并不需要一个特殊值。
 */
private func kl_nil() {
  
  let value:Int? = Int("123a");//Int()返回的是可选类型
  if value == nil{
    print("为nil");
  }
  
}

//MARK:可选值的强制解析
/*
 当确定可选类型含有值时可用，表示"我知道这个可选有值，请使用它"
 如果确定有值但最终没有值则崩溃
 
 如果用？定义常量/变量，和其他值通过操作符进行运算时，要加！，否则编译不通过
 */
private func kl_ForcedUnwrapping() {
  
  let value1:Int? = Int("123a");
  print(value1!);
  
  let value2:Int! = Int("123a");
  print(value2);
  
  let value3:Int? = Int("123");
  print(value3!+4);
  
}

//MARK:可选绑定
/*
 表示：如果返回的可选包含一个值，创建一个新常量并将可选包含的值赋给它。
 */
private func kl_OptionalBinding() {
  
  if let value = Int("123") {
    print("有值 \(value)");
  }else{
    print("无值 nil");
  }
  
  if let b = Int("123"),let bb = Int("3a") {
    print("有值 \(b) \(bb)");
  }else{
    print("无值 nil");
  }
}


//MARK:隐式解析可选
/*
 表示：第一次被赋值之后，可以确定一个可选总会有值
 如果一个变量之后可能变成nil的话请不要使用隐式解析可选。
 如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型。
 注：隐式可选也是可选类型
 */
private func kl_ImplicitlyUnwrappedOptionals(){
  
  let possibleString: String? = "An optional string."
  print(possibleString!) // 需要惊叹号来获取值
  
  let assumedString: String! = "An implicitly unwrapped optional string."
  print(assumedString) // 不需要感叹号
  
}
