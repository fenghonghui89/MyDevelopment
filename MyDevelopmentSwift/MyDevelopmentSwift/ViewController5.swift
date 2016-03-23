//
//  ViewController5.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController5: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    //TODO:--- for循环 ---
    //TODO:对区间操作符进行循环
    for index in 1...5
    {
      print("index:\(index)");
    }
    
    for index in 1..<10
    {
      print("index1:\(index)");
    }
    
    let base = 3;
    let power = 10;
    var answer = 1;
    for _ in 1...power
    {
      answer *= base;
    }
    print("\(answer)");
    
    //TODO:枚举数组和字典中的元素
    let arr = ["one","two",12];
    for value in arr
    {
      print("\(value)");
    }
    
    
    let dic = ["k1":"v1",1:3];
    for (k,v) in dic
    {
      print("k:\(k),v:\(v)");
    }
    
    
    //TODO:枚举字符串中的所有字符
    for character in "Hello World".characters
    {
      print("<\(character)>");
    }
    
    //TODO:条件增量for循环(循环标识如果在for外部定义则for内部不用加var)
    for var i = 0;i<3;i++
    {
      print("i:\(i)");
    }
    
    var ii = 0;
    for ii = 0;ii<3;ii++
    {
      print("ii:\(ii)");
    }
    
    
    
  }
}
