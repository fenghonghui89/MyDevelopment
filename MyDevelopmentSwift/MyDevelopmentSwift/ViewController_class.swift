//
//  ViewController_property.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/19.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_class: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad();
  
  
    func_subClass();
    
  }

  
  //MARK:- <<< method >>> -
  //MARK:base
  func func_objBase(){
    let Tom = Person();
    
    //存储属性
    Tom.name = "Tom";
    Tom.age = 12;
    Tom.parents = Parents(father: "Jim", mather: "Mary");
    
    //计算属性
    Tom.weight = 10;
    print("tom health \(Tom.health)");
    
    Tom.health = 20;
    print("tom weight \(Tom.weight)");
    
    //类属性
    let race = Person.race;
    print("person's race \(race)");
    print("category:\(Person.category)");
    
    //延迟加载属性在使用时才会计算初始值
    print("\(Tom.gene)");
    
    //属性监视器
    Tom.account = "123123";
    print("account:\(Tom.account)");
    
    
    
    Tom.study();
    
    func_objCompare();

  }
  
  
  
  //MARK:类是引用类型 恒等运算符(===,!==)
  func func_objCompare(){
    
    let p = Person();
    p.name = "Tom";
    
    let p1 = p;
    p1.name = "Ann";
    
    print(p.name,p1.name);
    
    if p === p1 {
      print("引用同一个实例");
    }else{
      print("不是同一个实例");
    }
  }
  
  //MARK:继承
  func func_subClass() {
    
    let Hany = AsiaPerson();
    print(Hany.name,Hany.age);
    
    print(Hany[3]);
  }
  
  
  
  
  
}




