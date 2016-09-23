//
//  OCClass.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/3.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//MARK:- 例子1
@objc protocol OCProtocol{

  optional var name:String{get};
  optional func study();
}

@objc class OCClass:NSObject{

  var student:OCProtocol
  
  init(student:OCProtocol) {
    self.student = student
  }
  
}


class Studnet: OCProtocol {
  
  @objc var name: String
  
  @objc func study() {
    print("study")
  }
  
  init(name:String){
    self.name = name;
  }
  
}



//MARK:- 例子2
@objc protocol CounterDataSource {
  optional func incrementForCount(count: Int) -> Int
  optional var fixedIncrement: Int { get }
}





class Counter {
  
  var count = 0
  var dataSource: CounterDataSource?

  func increment() {
    if let amount = dataSource?.incrementForCount?(count) {
      count += amount
    } else if let amount = dataSource?.fixedIncrement {
      count += amount
    }
  }
}


class ThreeSource:NSObject, CounterDataSource {
   let fixedIncrement = 3
}

//或者
//class ThreeSource: CounterDataSource {
//  @objc let fixedIncrement = 3
//}




@objc class TowardsZeroSource: NSObject, CounterDataSource {
  
  func incrementForCount(count: Int) -> Int {
    if count == 0 {
      return 0
    } else if count < 0 {
      return 1
    } else {
      return -1
    }
  }
}



