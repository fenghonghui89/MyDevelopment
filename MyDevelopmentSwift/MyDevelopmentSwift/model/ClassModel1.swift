//
//  AsiaPerson.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//

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
  
  //--- 类属性 ---
  //class修饰
  class var classProperty:String {
    return "classProperty";
  };
  
  //static修饰
  static var classProperty1:String = "classProperty1"
 
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

