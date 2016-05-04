//
//  ViewController3.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_BaseOperator: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  //MARK:数值运算
  func func_baseOperator() {
    
    1 + 2       // equals 3
    5 - 3       // equals 2
    2 * 3       // equals 6
    10.0 / 2.5  // equals 4.0
    -9 % 4   // equals -1
    8 % 2.5   // equals 0.5
    
    let three = 3
    let minusThree = -three       // minusThree equals -3
    let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
    
    let minusSix = -6
    let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
   
    var i:float_t = 1.1;
    i += 1;
    print("i = \(i)");
  }
  
  //MARK:元组间比较 三目运算符
  func func_compareOperator(){
    
    //元组间比较 从左往右逐一比较 最多比较6个 6个以上的比较要自己实现
    (1, "zebra") < (2, "apple")   // true because 1 is less than 2
    (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
    (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
    
    
    //三目运算符
    let contentHeight = 40
    let hasHeader = true
    let rowHeight = contentHeight + (hasHeader ? 50 : 20)// rowHeight is equal to 90
    
    
    let defaultColorName = "red"
    var userDefinedColorName: String? // defaults to nil
    var colorNameToUse = userDefinedColorName ?? defaultColorName //red
    userDefinedColorName = "green"
    colorNameToUse = userDefinedColorName ?? defaultColorName // green
    
  }
  
  //MARK:区间操作符 - 半开半闭
  func func3() {
    let names = ["a","b","c","d"];
    for i in 0..<names.count{//包含0123 不包含4
      print("第\(i+1)个字母：\(names[i])");
    }
  }
  
  //MARK:区间操作符 - 全闭合
  func func4() {
    for i in 1...5{
      print(i);
    }
  }
  
  
}
