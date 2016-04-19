//
//  ViewController3.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_symbol: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    
    

    
  
    
    
    
    
    
  }
  
  //MARK: - <<< method >>> -
  //MARK:跟oc不同不允许溢出/用&强制输出溢出值
  func func1() {
    
//    let x:Int = 112233*112233;
//    print(x);
//    
//    let x1:Int = 112233;
//    var y1:Int = 112233*x1;
//    print(y1);

    //用&强制输出溢出值
    let x3:Int = 112233;
    var y3:Int = 112233 &* x3;
    print(y3);

  }
  
  //MARK:可以浮点数求余 浮点数自增自减1
  func func2() {
    
    print(8.5%2.5);
    
    
    var i:float_t = 1.1;
    i++;
    print("i = \(i)");
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
