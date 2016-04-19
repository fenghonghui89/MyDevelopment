//
//  Person.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//

/*
 类
 计算型类属性用class关键字，set
 存储型类属性用static关键字
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
    
    //1.1 newValue是隐藏属性
//    set{
//    weight = newValue;
//    }
    
    //1.2也可以自己赋值
    set(newHealth){
      weight = 0.5*newHealth;
    }
    
    //1.3这样写会死循环
//    set{
//      self.health = newValue;
//    }

  }
  
  //MARK:类属性
  /*
   跟实例的存储属性不同，必须给存储型类型属性指定默认值，因为类型本身无法在初始化过程中使用构造器给类型属性赋值
   class只支持计算型类型属性 不支持存储型类型属性
   存储型类属性用static
   */
  class var race:String {
    
    get{
      return "human";
    }
  
    //不能写set 会死循环
//    set(newValue){
//      self.race = newValue;
//    }
  }
  static var category:String = "Animal";
  
  //MARK:延时加载属性
  /*
   如果属性的值依赖外部传入，或者依赖复杂大量的运算，可以只在使用的时候再计算他
   必须是var声明
   */
  lazy var gene:[Int] = [0,1,2,3,4];
  
  //MARK:属性监视器
  /*
   作用类似oc的set
   初始化的时候不会触发
   哪怕新值和旧值一样 也会触发
   如果在didSet监视器里为属性赋值，这个值会替换监视器之前设置的值
   */
  var account:String = "默认account"{
    willSet{
      print("account willSet:\(newValue)");
    }
    
    didSet{
      print("account didSet,oldValue:\(oldValue)");
      self.account = "444444";
    }
  };
  
  //MARK:附属脚本
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