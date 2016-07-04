//
//  File.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/16.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation



protocol SomeProtocol {
  init()
}

class SomeSuperClass {
  
  init() {
    // initializer implementation goes here
  }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
  
  // "required" from SomeProtocol conformance; "override" from SomeSuperClass
  required override init() {
    
  }

}

