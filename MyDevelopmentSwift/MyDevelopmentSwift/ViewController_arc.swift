//
//  ViewController_arc.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/20.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_arc: UIViewController {
  
  var obj:ChildClass?;
  
  
  override func viewDidLoad() {
    super.viewDidLoad();
  
    func1_2();
  }
  
  
  //MARK:arc base
  func func1_1(){
    
    var obj:ChildClass?;
    var obj1:ChildClass?;
    var obj2:ChildClass?;
    
    obj = ChildClass(isChild: true);
    obj1 = obj;
    obj2 = obj1;
    self.obj = obj;
  }
  
  //MARK:weak
  func func1_2(){
    
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
  
  init(number:Int){
    self.number = number;
  }
  
  deinit{
    print("CreditCard deinit");
  }
}