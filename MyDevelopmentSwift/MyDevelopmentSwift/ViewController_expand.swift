//
//  ViewController_expand.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/26.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_expand: UIViewController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad();
    
    func1();
  }
  
  //MARK:- <<< method >>>
  
  func func1() {
    
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")// 打印输出："One inch is 0.0254 meters"
    
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")// 打印输出："Three feet is 0.914399970739201 meters"
    
    let aMarathon = 42.km + 195.m
    print("A marathon is \(aMarathon) meters long")// 打印输出："A marathon is 42495.0 meters long"
  }
}


//MARK:- <<< class >>>
extension Double{

  var km: Double { return self * 1_000.0 }
  var m : Double { return self }
  var cm: Double { return self / 100.0 }
  var mm: Double { return self / 1_000.0 }
  var ft: Double { return self / 3.28084 }
  

  
}