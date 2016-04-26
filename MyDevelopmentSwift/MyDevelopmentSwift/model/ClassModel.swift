//
//  AsiaPerson.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//

/*
 类 关键字
 
 mutating 
 类不能用这个关键字 因为不像struct/enum有变异方法 也没必要有变异方法
 
 final 
 不允许复写
 
 weak 
弱引用 必须是var+可选类型（？or!）
修饰变量时默认值为nil 例如: weak var person:Person?/!
设置为weak的属性，则对象不持有该属性所指向的对象
如果在方法里面 用weak修饰一个对象类型 就算给他赋值也是为nil 不持有对象
只能用在对象
 
 unowned 
无主引用 必须要有默认值 不管是直接赋值还是通过指定构造方法赋值 所以不能用可选类型
修饰变量时默认有值 例如: unowned var person:Person
 设置为unowned的属性，则对象不持有该属性所指向的对象
 如果在方法里面 用unowned修饰一个对象类型 默认有值 不持有对象 调用对象会崩但跟weak报错不一样
 只能用在对象
 
 lazy 
 延时加载 可以用self 因为一定是实例化后才会调用的
如果类型是block 必须是var不能是let
 子类复写时不能加lazy关键字
 
 class 
 修饰类属性 必须指定值，因为无法在构造过程中设置
          不能用闭包/等号赋默认值 只能用get方法设置默认值 不能写set否则死循环
           子类可以复写 复写依旧只能用get方法设置默认值 不能写set否则死循环
修饰类方法 子类可以复写
 
 static 
 修饰类属性 必须指定值，因为无法在构造过程中设置
           可以用闭包/等号/get方法 赋默认值
           子类不能复写
修饰类方法 子类不能复写
 
 willSet/didSet 
 作用类似oc的set
 初始化的时候不会触发
 哪怕新值和旧值一样 也会触发
 willSet有newValue，didset有oldValu
 如果在didSet监视器里为属性赋值，这个值会替换监视器之前设置的值
 
 subscript 
 附属脚本 调用方法为 objName[parama]，例如 person[10]
必须要有get，set可选

 
 deinit 
 反构造 相当于dealloc 子类不能复写 不用加()
 
 convenience 
 便利构造方法 一般为：convenience init(参数可有可无){self.init...}
 
 存储属性  
 实例的 - 一般，var+可选类型可以不定义默认值，否则都要有默认值，都必须在定义属性的地方或者指定构造方法里面赋值
         特别的，在“ViewController_arc - unowned以及隐式解析可选属性”例子中，Country类的capitalCity属性不单要有默认值，还必须是var
 类的 -  所有类型要有默认值
 
 计算属性 
 本身不是一个值
 必须用var,因为不是固定的
 计算属性的set/get跟oc的set/get不一样，这里是set其他属性的值，通过其他属性的值get自己
 只有get没有set的话则是只读计算属性
 
 */
import Foundation

struct Parents {
  let father:String
  let mather:String
  
}
class SuperClass{
  
  //--- 实例属性 ---
  //存储型
  final var storeProperty:String = "storeProperty";
  var storeProperty1:String = "storeProperty";
  var parents:Parents?

  
  
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
    get{
      return "classProperty"
    }
  }
  
  
  //static修饰
  static var cp11:String{
    get{
    return ""
    }
  }
  
  static var classProperty1:String = {
    return "classProperty1"
  }()
 
  static var cp2:()->String = {
    return "cp2";
  }
  
  //类方法
  class func classMethod() {
    print("classMethod");
  }
  
  static func classMethod1() {
    print("classMethod1");
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
    print("SuperClass init:\(self.storeProperty) \(self.storeProperty1)");
  }
  
  //便利构造
  convenience init(){
    self.init(par1:"par1",par2:"par2")
  }
  
  //反构造
  deinit{
    print("SuperClass deinit");
  }
}


class ChildClass: SuperClass {
  
  //--- 属性 ---
  override var storeProperty1: String{
  
    willSet{
    
    }
  }
  
  override class var classProperty:String{
    get{
      return "classProperty"
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

