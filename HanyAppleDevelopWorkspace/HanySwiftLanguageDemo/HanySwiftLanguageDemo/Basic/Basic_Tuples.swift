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
    
    let pp1 = (11);
    print(pp1);
    
    let pp2 = (11,111,1111);
    print(pp2.2);//1111
    
    let pp3 = (p1:11,p2:111,p3:111);
    print(pp3.p1);//11
}

//MARK:元组分解
private func kl_getValueByAssignment() {
    
    //通过赋值给其他常变量 取元组的元素值
    let product1 = (20,"iphone5",5000);
    let (id,name,price) = product1;
    print("id:\(id)  name:\(name) price:\(price)");
    
    //不想取全部值则用下划线
    let (_,name1,_) = product1;
    print("name1:\(name1)");
}
