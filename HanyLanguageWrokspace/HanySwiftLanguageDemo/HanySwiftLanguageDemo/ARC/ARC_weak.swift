//
//  ARC_weak.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation


func root_ARC_weak() {
  
}

//MARK:- weak 解决引用环 / weak unowned修饰变量的差异

private class arc_weak_result{
  
  
  init(){
    
    f1();
    
    
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
    weak var customer:Customer? = Customer(name: "Hany");
    print(customer!.name);//会崩，因为customer初始为nil，且weak不持有实例
    print("!！");
    
    //unowned
    //    unowned var customer1:Customer = Customer(name: "Hany");
    //    print(customer1.name);//会崩，因为customer初始虽然有值，但unowned不持有实例
    //    print("!！");
    
  }
}

private class Customer {
  
  var name:String = "";
  var hotel:Hotel?;
  
  init(name:String){
    self.name = name;
  }
  
  deinit{
    print("custom deinit");
  }
}

private class Hotel {
  
  var number:Int = 0;
  weak var customer:Customer?;
  
  init(number:Int){
    self.number = number;
  }
  
  deinit{
    print("hotel deinit");
  }
}
