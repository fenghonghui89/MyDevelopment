//
//  ViewController_AccessControl.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/1.
//  Copyright © 2016年 MD. All rights reserved.
//已看
/*
 元组类型的访问级别 相当于当中所有类型的最受限的级别
 
 默认是internal 如果是framework则是public
 
 返回值的级别是私有 则方法必须标识私有
 
 嵌套类型的访问级别会根据环境自动推导 提示你修改
 
 同一源文件下 就算子类访问级别低 也能访问父类
 
 自定义初始化的访问级别等于或者低于原始初始化，唯一例外是required init 访问级别必须跟类的访问级别一样
 要传参的初始化的访问级别跟类的存储属性的最低访问级别相同，如果参数是私有则传参初始化也是私有。
 */
import UIKit

class ViewController_AccessControl: UIViewController {
  
  override func viewDidLoad() {
    
    
    
    
    var stringToEdit = TrackedString()
    stringToEdit.numberOfEdits = 4;
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
    // Prints "The number of edits is 7"
    

  }
  
  
}

//MARK:访问控制语法
//public class SomePlublicClass{}
//internal class SomeInternalClass{}
//private class SomePrivateClass{}
//
//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//private func somePrivateFunction() {}



//MARK:指定访问级别
public class SomePublicClass {          // explicitly public class
  public var somePublicProperty = 0    // explicitly public class member
  var someInternalProperty = 0         // implicitly internal class member
  private func somePrivateMethod() {}  // explicitly private class member
}

class SomeInternalClass {               // implicitly internal class
  var someInternalProperty = 0         // implicitly internal class member
  private func somePrivateMethod() {}  // explicitly private class member
}

private class SomePrivateClass {        // explicitly private class
  var somePrivateProperty = 0          // implicitly private class member
  func somePrivateMethod() {}          // implicitly private class member
}

private class AC_Class{
  
  //返回值的级别是私有 则方法必须标识私有
  private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return(SomeInternalClass.init(), SomePrivateClass.init());
  }
  
  //嵌套类型的访问级别会根据环境自动推导
  private enum CompassPoint {
    case North
    case South
    case East
    case West
  }
  
  

}

public enum CompassPoint {
  case North
  case South
  case East
  case West
}


//MARK:子类的访问级别
public class A {
  private func someMethod() {}
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
  public private(set) var numberOfEdits = 0
  public var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
  public init() {}
}

class SuperAC {
  
  private func func_private(){
  
  }
  
  
}

//MARK:初始化 协议 扩展 泛型 类型别名 详见官文

