//
//  Person1.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
/*
 协议组合 类似于oc的id<delegate1,delegate2...>
*/


import Foundation


class Person1:Named,Aged {

  var name: String
  var age: String
  
  init(name:String,age:String){
    self.name = name;
    self.age = age;
  }
  
  func wishHappyBirthday(celebrator: protocol<Named,Aged>) {//协议组合
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
  }
}

