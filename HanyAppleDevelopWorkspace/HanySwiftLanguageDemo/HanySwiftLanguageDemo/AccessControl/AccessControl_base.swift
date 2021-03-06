//
//  AccessControl_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//访问控制

import Foundation

func root_AccessControl_base() {
  
}

private func AccessControl_show() {
  
  var stringToEdit = TrackedString()
  stringToEdit.numberOfEdits = 4;
  stringToEdit.value = "This string will be tracked."
  stringToEdit.value += " This edit will increment numberOfEdits."
  stringToEdit.value += " So will this one."
  print("The number of edits is \(stringToEdit.numberOfEdits)")
  // Prints "The number of edits is 7"
  
  
}







//MARK:指定访问级别

//public
open class SomePublicClass {          // explicitly public class
  open var somePublicProperty = 0    // explicitly public class member
  var someInternalProperty = 0         // implicitly internal class member
  fileprivate func somePrivateMethod() {}  // explicitly private class member
}

//internal
internal class SomeInternalClass {      // implicitly internal class
  var someInternalProperty = 0         // implicitly internal class member
  fileprivate func somePrivateMethod() {}  // explicitly private class member
}

//private
private class SomePrivateClass {        // explicitly private class
  var somePrivateProperty = 0          // implicitly private class member
  func somePrivateMethod() {}          // implicitly private class member
}

private class AC_Class{
  
  //返回值的级别是私有 则方法必须标识私有
  fileprivate func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return(SomeInternalClass.init(), SomePrivateClass.init());
  }
  
  //嵌套类型的访问级别会根据环境自动推导
  fileprivate enum CompassPoint {
    case north
    case south
    case east
    case west
  }
  
  
  
}

public enum CompassPoint {
  case north
  case south
  case east
  case west
}


//MARK:子类的访问级别
open class A {
  fileprivate func someMethod() {}
}

internal class B: A {
  override internal func someMethod() {
    super.someMethod()
  }
}

//MARK:常量 变量 属性 附属脚本
private var privateInstance = SomePrivateClass();




//struct TrackedString {
//  private(set) var numberOfEdits = 0
//  var value: String = "" {
//    didSet {
//      numberOfEdits += 1
//    }
//  }
//}



public struct TrackedString {
  public fileprivate(set) var numberOfEdits = 0
  public var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
  public init() {}
}

class SuperAC {
  
  fileprivate func func_private(){
    
  }
  
  
}

//MARK:初始化 协议 扩展 泛型 类型别名 详见官文
