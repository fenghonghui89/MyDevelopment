//
//  Person1.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation



class Person1:Named,Aged {

  var name: String
  var age: String
  
  init(name:String,age:String){
    self.name = name;
    self.age = age;
  }
  
  func wishHappyBirthday(celebrator: protocol<Named,Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
  }
}

class Person2:Named,Aged {
  
  var name: String
  var age: String
  
  init(name:String,age:String){
    self.name = name;
    self.age = age;
  }
}