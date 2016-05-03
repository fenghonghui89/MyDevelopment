//
//  OCClass.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/3.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

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