//
//  Basic_Tuples.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//元组

import Foundation

func root_Basic_Tuples() {
  kl_getValueByIndex();
}

//MARK:通过下标取元组的元素值
private func kl_getValueByIndex() {
  
  let pp = (11,111,1111);
  print(pp.2);//1111
  
}

//MARK:通过赋值给其他常变量取元组的元素值/不想取全部值则用下划线
private func kl_getValueByAssignment() {
  
  //通过赋值给其他常变量取元组的元素值
  let product1 = (20,"iphone5",5000);
  let (id,name,price) = product1;
  print("id:\(id)  name:\(name) price:\(price)");
  
  //不想取全部值则用下划线
  let (_,name1,_) = product1;
  print("name1:\(name1)");
}



//MARK:为元组中的元素命名
private func kl_name() {
  
  let product2 = (30,name:"iphone8",price:5000);
  print(product2.name+" "+"price:\(product2.price)");
  
  let (x,y,z) = (1.1,"iphone",3);
  print(x,y,z);
}
