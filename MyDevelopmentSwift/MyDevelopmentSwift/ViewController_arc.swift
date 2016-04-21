//
//  ViewController_arc.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/20.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_arc: UIViewController {
  

  
  
  override func viewDidLoad() {
    super.viewDidLoad();
  
//    let obj = arc_unowned_result();
    
    let obj = SuperClass();
    let  s = obj.lazyBlock
    
  }
  
  

  

}

//MARK:- <<< class >>>
//MARK:- arc base
class arc_base_result{

  var obj:ChildClass?;
  
  init(){
    var obj:ChildClass?;
    var obj1:ChildClass?;
    var obj2:ChildClass?;
    
    obj = ChildClass(isChild: true);
    obj1 = obj;
    obj2 = obj1;
    self.obj = obj;
  }
}

//MARK:- weak 解决引用环
/*
 两个对象互相引用 都可以为Nil
 */
class arc_weak_result{
  
  
  init(){
    var customer:Customer?;
    var hotel:Hotel?;
    
    customer = Customer(name: "Hany");
    hotel = Hotel(number: 12);
    
    customer!.hotel = hotel;
    hotel!.customer = customer;
    
    customer = nil;
    hotel = nil;
  }
}

class Customer {
  
  var name:String = "";
  var hotel:Hotel?;
  
  init(name:String){
    self.name = name;
  }
  
  deinit{
    print("custom deinit");
  }
}

class Hotel {
  
  var number:Int = 0;
  weak var customer:Customer?;//weak修饰的属性必须为可选类型
  
  init(number:Int){
    self.number = number;
  }
  
  deinit{
    print("hotel deinit");
  }
}

//MARK:- unowned 解决引用环
/*
 两个对象互相引用 一个可以为nil 一个不为nil
 */
class arc_unowned_result{
  
  init(){
    var bankCustomer:BankCustomer?;
    
    bankCustomer = BankCustomer(name: "Hany");
    bankCustomer?.creditCard = CreditCard(number: 1, bankCustomer: bankCustomer!);
    bankCustomer = nil;
    
  }
}

class BankCustomer {
  
  var name:String = ""
  var creditCard:CreditCard?
  
  init(name:String){
    self.name = name;
  }
  
  deinit{
    print("BankCustomer deinit");
  }
  
}

class CreditCard {
  
  var number:Int = 0;
  unowned var bankCustomer:BankCustomer;
  
  init(number:Int,bankCustomer:BankCustomer){
    self.number = number;
    self.bankCustomer = bankCustomer
  }
  
  deinit{
    print("CreditCard deinit");
  }
}


//MARK:- 隐式
