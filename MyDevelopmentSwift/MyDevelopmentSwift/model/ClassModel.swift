//
//  Person.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//

/*
 类
 没有变异方法
 */


import Foundation

struct Parents {
  var father:String = "";
  var mather:String = "";
}


class Person{
  
  //MARK:- property
  //MARK:存储属性
  /*
   枚举、结构体的存储属性可以没有默认值
   类的存储属性要有默认值
   */
  var name:String = "";
  var age:Int = 0;
  var parents = Parents();
  
  //MARK:计算属性
  /*
   计算属性本身不是一个值
   计算属性必须用var,因为不是固定的
   计算属性的set/get跟oc的set/get不一样，这里是set其他属性的值，通过其他属性的值get自己
   只有get没有set的话则是只读计算属性
   */
  var weight:Double = 0;
  var health:Double{
    get{
      return weight*0.5;
    }
    set(newHealth){
      weight = 0.5*newHealth;
    }
  }
  
  //MARK:类属性
  /*
   必须指定值，因为无法在构造过程中设置
   计算型类属性用class关键字 不能写set否则死循环
   存储型类属性用static关键字 static修饰的不能复写？
   */
  class var race:String {
    
    get{
      return "human";
    }
  
  }
  static var category:String = "Animal";
  
  //MARK:延时加载属性
  /*
   如果属性的值依赖外部传入，或者依赖复杂大量的运算，可以只在使用的时候再计算他
   必须是var声明
   不能复写？
   */
  lazy var gene:[Int] = [0,1,2,3,4];
  
  //MARK:属性监视器
  /*
   作用类似oc的set
   初始化的时候不会触发
   哪怕新值和旧值一样 也会触发
   如果在didSet监视器里为属性赋值，这个值会替换监视器之前设置的值
   */
  var account:String = ""{
    willSet{
      print("account willSet:\(newValue)");
    }
    
    didSet{
      print("account didSet,oldValue:\(oldValue)");
      self.account = "444444";
    }
  };
  
  //MARK:附属脚本
  /*
   附属脚本调用方法：对象名[参数]
   */
  subscript (index:Int)->Int{
    get{
      return gene[index];
    }
    
  }
  
  //MARK:- function
  init(){
    self.name = "default name";
    self.age = 0;
  }
  
  init(name:String, age:Int){
    self.name = name;
    self.age = age;
  }
  
  func study(){
    print("\(self.name) \(self.age) is studying");
  }
  
  class func classMethod() {
    print("this is class method");
  }
  
  func objMethod() {
    self.name = "sb";
    self.age = 12;
  }

  
  
  
  
  
  
}