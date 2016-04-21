//
//  AsiaPerson.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//

/*
 关键字
 final - 不允许复写
 weak 弱引用 必须是var 必须是可选类型
 unowned 无主引用 不能用可选类型
 lazy 延时加载 如果类型是block 可以用self
 class 类属性 不能用等号/闭包赋默认值 要用get方法设置默认值；也可以修饰类方法
 static 类属性 可以用等号/闭包赋默认值；也可以修饰类方法
 */
import Foundation


class SuperClass{
  
  //--- 实例属性 ---
  //存储型
  final var storeProperty:String = "storeProperty";
  var storeProperty1:String = "storeProperty";
  
  //通过闭包设置的存储型属性
  var storeProperty2:String = {
    return "storeProperty2";
  }()
  
  var storeProperty3:()->String = {
    return "storeProperty2";
  }
  
  //计算型
  var computeProperty:String = "computeProperty";
  var computeProperty1:String{
    get{
      return String(computeProperty+"111");
    }
    
    set{
      computeProperty = "computeProperty";
    }
    
  }
  
  //属性观察者
  var ProtertyMonitor:String = "ProtertyMonitor"{
    didSet{
      print("");
    }
    
    willSet{
      print("");
    }
    
  };
  
  //延时加载型
  lazy var lazyProperty:String = "lazyProperty";
  lazy var lazyBlock:()->String = {
    return self.storeProperty;
  }
  
  lazy var lazyBlock1:String = {
    return self.storeProperty;
  }()
  
  //--- 类属性 类方法---
  //class修饰
  class var classProperty:String{
    return "classProperty";
  }
  
  
  //static修饰
  static var classProperty1:String = {
    return "classProperty1"
  }()
 
  static var cp2:()->String = {
    return "cp2";
  }
  
  //类方法
  static func classMethod() {
    print("classMethod");
  }
  
  //--- 附属脚本 ---
  //附属脚本1
  var subscriptProperty:[Int] = Array.init(count: 10, repeatedValue: 2);
  subscript (index index:Int, count count:Int)->Int{
    get{
      print("SuperClass subscript get");
      return subscriptProperty[index]*count;
    }
    
    set{
      print("SuperClass subscript set");
      subscriptProperty[index] = index*count;
    }
  }
  
  //附属脚本2
  enum MealTime
  {
    case Breakfast
    case Lunch
    case Dinner
  }
  
  var meals:[MealTime:String] = [:]
  subscript(requestedMeal:MealTime)->String{
    
    get{
      if let thisMeal = meals[requestedMeal]{
        return thisMeal
      }else{
        return "Ramen"
      }
    }
    
    set(newMealName){
      meals[requestedMeal] = newMealName
    }
  }

  //--- 方法 ---
  //指定构造
  init(par1:String, par2:String){
    self.storeProperty = par1;
    self.storeProperty1 = par2;
    print("SuperClass init");
  }
  
  //便利构造
  convenience init(){
    self.init(par1:"par1",par2:"par2")
  }
  
  //反构造 相当于dealloc 不能复写 不用加()
  deinit{
    print("SuperClass deinit");
  }
}


class ChildClass: SuperClass {
  
  //--- 属性 ---
  override var storeProperty1:String{
    willSet{
    
    }
  }
  
  var isChild:Bool = false;
  
  //--- 方法 ---
  init(isChild:Bool,storeProperty:String,storeProperty1:String){
    self.isChild = isChild;
    super.init(par1: storeProperty, par2: storeProperty1);
  }
  
  convenience init(isChild:Bool){
    print("ChildClass init");
    self.init(isChild:isChild,storeProperty:"par1",storeProperty1:"par2");
  }
  
  deinit{
    print("ChildClass deinit");
  }
}

