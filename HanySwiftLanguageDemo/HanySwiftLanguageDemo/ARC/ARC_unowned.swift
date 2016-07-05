//
//  ARC_unowned.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

func root_ARC_unowned() {
  
}
//MARK:- unowned 解决引用环
private class arc_unowned_result{
  
  init(){
    
    //CreditCard实例被creditCard对象和bankCustomer对象的属性持有，引用计数+2
    //    var bankCustomer:BankCustomer?
    //    var creditCard:CreditCard?
    //
    //    bankCustomer = BankCustomer(name: "Hany")
    //    creditCard = CreditCard(number: 12, bankCustomer: bankCustomer!)
    //    bankCustomer!.creditCard = creditCard;
    
    //CreditCard实例只被bankCustomer的属性持有，引用计数+1
    var bankCustomer:BankCustomer? = BankCustomer(name: "Hany")
    bankCustomer!.creditCard = CreditCard(number: 12, bankCustomer: bankCustomer!);
    
    print("~~")
    bankCustomer = nil;
    print("!!!")
    
  }
}


private class BankCustomer {
  
  var name:String = ""
  var creditCard:CreditCard?
  
  init(name:String){
    self.name = name;
  }
  
  deinit{
    print("BankCustomer deinit");
  }
  
}

private class CreditCard {
  
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


//MARK:- unowned以及隐式解析可选属性
/*
 两个对象互相引用 都不可以为nil
 */
private class arc_unowned2_result{
  
  init(){
    
    var country:Country? = Country(name: "China", capitalName: "Biejing")
    
    print("~~")
    country = nil;
    print("!!!")
  }
}


private class Country {
  
  let name: String
  var capitalCity: City!//隐式解析可选属性 这里必须是var否则编译不过
  
  init(name: String, capitalName: String) {
    self.name = name
    self.capitalCity = City(name: capitalName, country: self)
  }
  
  deinit{
    print("country deinit");
  }
}

private class City {
  
  let name: String
  unowned let country: Country//无主引用
  
  init(name: String, country: Country) {
    self.name = name
    self.country = country
  }
  
  deinit{
    print("city deinit");
  }
}
