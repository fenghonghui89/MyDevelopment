//
//  Class_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//MARK:- <<< method >>> -


//MARK:类是引用类型 恒等运算符(===,!==)
func func_objCompare(){
  
  let p = SuperClass();
  p.storeProperty = "Tom";
  
  let p1 = p;
  p1.storeProperty = "Ann";
  
  print(p.storeProperty,p1.storeProperty);
  
  if p === p1 {
    print("引用同一个实例");
  }else{
    print("不是同一个实例");
  }
}

//MARK:继承
func func_subClass() {
  
  //    let child = ChildClass(isChild: true);
  //    print("\(child.storeProperty),\(child.storeProperty1)");
  
  print("\(SuperClass.classProperty)  \(SuperClass.classProperty1)")
  SuperClass.classMethod();
  SuperClass.classMethod1();
}
