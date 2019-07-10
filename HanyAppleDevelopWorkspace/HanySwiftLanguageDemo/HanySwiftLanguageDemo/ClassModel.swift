//
//  AsiaPerson.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//


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
    var ssss:String = {
        return ""
        
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
    
    static var cp2:(_ value:String)->String = {
        (value) -> String in
        return String(value+"~~");
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
    var subscriptProperty:[Int] = Array.init(repeating: 2, count: 10);
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
        case breakfast
        case lunch
        case dinner
    }
    
    var meals:[MealTime:String] = [:]
    subscript(requestedMeal:MealTime)->String{
        
        get{
            if let thisMeal = meals[requestedMeal]{
                return thisMeal
            }else{
                return "没有定义的一餐？"
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
    
    //可选指定构造
    init?(p1:String,p2:String){
        if (p1.isEmpty && p2.isEmpty) {
            return nil;
        }
        self.storeProperty = p1;
        self.storeProperty1 = p2;
        print("SuperClass init?:\(self.storeProperty) \(self.storeProperty1)");
    }
    
    //required init 子类必须复写且也要加required
    required init(a:String,b:String,c:String){
        
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
    init?(isChild:Bool,storeProperty:String,storeProperty1:String){
        self.isChild = isChild;
        super.init(par1: storeProperty, par2: storeProperty1);
    }
    
    convenience init?(isChild:Bool){
        print("ChildClass init");
        self.init(isChild:isChild,storeProperty:"par1",storeProperty1:"par2");
    }
    
    deinit{
        print("ChildClass deinit");
    }
    
    
    override init?(p1: String, p2: String) {
        super.init(p1: p1, p2: p2);
    }
    
    required init(a: String, b: String, c: String) {
        super.init(a: a, b: b, c: c)
    }
    
}

