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
  
    let obj = arc_unowned2_result();
  }
  
  

  

}

//MARK:- <<< class >>>
//MARK:- arc base
/*
 默认将一个实例赋值给一个不带weak的属性/变量/常量，这个属性/变量/常量就会持有这个实例，引用计数+1
 var+可选类型的对象才能置nil，但对象的属性另计，对象的属性根据属性关键字处理
 */
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

//MARK:- weak 解决引用环 / weak unowned修饰变量的差异

class arc_weak_result{
  
  
  init(){
    
    f2();
    
    
  }
  
  //weak解决引用环
  func f1(){
    var customer:Customer?;
    var hotel:Hotel?;
    
    customer = Customer(name: "Hany");
    hotel = Hotel(number: 12);
    
    customer!.hotel = hotel;
    hotel!.customer = customer;
    
    hotel = nil;
    customer = nil;
  }
  
  //weak unowned修饰变量的差异
  func f2(){
    
    //weak
    weak var customer:Customer?;
    customer = Customer(name: "Hany");
    print(customer!.name);//会崩，因为customer初始为nil，且weak不持有实例
    print("!！");
    
    //unowned
//    unowned var customer1:Customer;
//    customer1 = Customer(name: "Hany");
//    print(customer1.name);//会崩，因为customer初始虽然有值，但unowned不持有实例
//    print("!！");

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
  weak var customer:Customer?;
  
  init(number:Int){
    self.number = number;
  }
  
  deinit{
    print("hotel deinit");
  }
}

//MARK:- unowned 解决引用环
class arc_unowned_result{
  
  init(){
    
    //creditCard持有CreditCard实例，引用计数+1
//    var bankCustomer:BankCustomer?
//    var creditCard:CreditCard?
//    
//    bankCustomer = BankCustomer(name: "Hany")
//    creditCard = CreditCard(number: 12, bankCustomer: bankCustomer!)
//    bankCustomer!.creditCard = creditCard;
    
    //CreditCard实例只有被bankCustomer持有
    var bankCustomer:BankCustomer?
    bankCustomer = BankCustomer(name: "Hany")
    bankCustomer!.creditCard = CreditCard(number: 12, bankCustomer: bankCustomer!);
    
    print("~~")
    bankCustomer = nil;
    print("!!!")
    
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
    self.bankCustomer = bankCustomer;//unowned修饰的属性必须要有默认值
  }

  
  deinit{
    print("CreditCard deinit");
  }
}


//MARK:- 无主引用以及隐式展开的可选属性
/*
 两个对象互相引用 都不可以为nil
 */
class arc_unowned2_result{

  init(){
    
    var country:Country! = Country(name: "China", capitalName: "Biejing")
    
   print("~~")
    country = nil;
    print("!!!")
  }
}


class Country {
  
  let name: String
  var capitalCity: City!
  
  init(name: String, capitalName: String) {
    self.name = name
    self.capitalCity = City(name: capitalName, country: self)
  }
  
  deinit{
    print("country deinit");
  }
}

class City {
  
  let name: String
  unowned let country: Country
  
  init(name: String, country: Country) {
    self.name = name
    self.country = country
  }
  
  deinit{
    print("city deinit");
  }
}
