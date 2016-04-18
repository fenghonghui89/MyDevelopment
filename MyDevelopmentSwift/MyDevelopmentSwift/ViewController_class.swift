//
//  ViewController_class.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation
import UIKit
class ViewController_class:UIViewController{
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    
    func3();
    
    
    
  }
  
  //MARK: - <<< method >>>
  //MARK:创建实例
  func func1() {
    
    let astruct = Astruct(width: 10,height:10);
    let obj = Aclass();
    obj.name = "ACE";
    obj.astruct = astruct;
    print(obj.name,obj.astruct.width);
  }
  
  //MARK:结构体是值类型
  func func2() {
    
    let bstruct = Astruct(width: 20, height: 20);
    var cinema = bstruct;
    cinema.width = 11;
    print(bstruct,cinema);
  }
  
  //MARK:类是引用类型 恒等运算符(===,!==)
  func func3(){
    
    let obj1 = Aclass();
    obj1.rate = 20;
    
    let obj2 = obj1;
    obj2.rate = 30;
    
    print(obj1.rate,obj2.rate);
    
    if obj1 === obj2 {
      print("引用同一个实例");
    }
  }
}

//MARK:- 结构体 类
struct Astruct {
  var width = 0;
  var height = 0;
}


class Aclass {
  
  var astruct = Astruct();
  var name:String = "";
  var rate = 0.0;
}