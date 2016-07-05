//
//  ARC_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//ARC

import Foundation

func root_ARC_base() {
  
}

//MARK:- <<< class >>>
//MARK:- arc base
/*
 默认将一个实例赋值给一个不带weak的属性/变量/常量，这个属性/变量/常量就会持有这个实例，引用计数+1
 var+可选类型的对象才能置nil，但对象的属性另计，对象的属性根据属性关键字处理
 */
private class arc_base_result{
  
  var obj:ChildClass?;
  
  init(){
    var obj:ChildClass?;
    var obj1:ChildClass?;
    var obj2:ChildClass?;
    
    obj = ChildClass(isChild: true);
    obj1 = obj;
    obj2 = obj1;
    self.obj = obj;
    
    /*
     ChildClass init
     SuperClass init:par1 par2
     ChildClass deinit
     SuperClass deinit
     */
  }
}




