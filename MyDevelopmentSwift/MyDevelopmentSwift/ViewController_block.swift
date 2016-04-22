//
//  ViewController_block.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/4/16.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit


class ViewController_block: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    
    funcResult5();
  }
  
  
  //MARK:- < 推导例子 - 数组排序 >
  func func1() {
    
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
    
    var reversed:[String];
    
    //原始
    func backwards(s1: String, s2: String) -> Bool {
      return s1 < s2
    }
    
    reversed = names.sort(backwards);
    
    //优化
    reversed = names.sort({(s1: String, s2: String) -> Bool in return s1 > s2});
    reversed = names.sort({ s1, s2 in return s1 > s2 });
    reversed = names.sort({s1, s2 in s1 > s2});
    reversed = names.sort({ $0 > $1 } );
    reversed = names.sort(>);
    
    for i in reversed {
      print(i);
    }
  }
  
  
  
  //MARK:- < trailing闭包 类似于oc的block >
  func func2() {
    
    let digitNames = [
      0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
      5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ];
    
    let numbers = [16, 58, 510];
    
    
    let strings = numbers.map {
      (var number) -> String in //参数 返回值（参数名和类型要手动修改）
      
      //函数体
      var output = "";
      while number > 0 {
        output = digitNames[number % 10]! + output;
        number /= 10;
      }
      return output;
    };
    
    print(strings);
  }
  
  
  //MARK:- < 嵌套函数是最简单的闭包 捕获引用 闭包和函数是引用类型 >
  func func3_result() {
    
    //普通闭包 不捕获值
    var result1 = func3_1(forIncrement: 4);
    result1 = func3_1(forIncrement: 4);
    print(result1);
    
    //捕获了runningTotal变量的引用 即使退出了也不会消失
    let result2_1 = func3_2(forIncrement: 10);
    var value2_1 = result2_1();//10
    value2_1 = result2_1();//20
    print(value2_1);
    
    //新的变量拥有新的引用 跟上面的不相关
    let result2_2 = func3_2(forIncrement: 7);
    var value2_2 = result2_2();//7
    value2_2 = result2_2();//14
    print(value2_2);
    
    //返回外部定义的函数类型 不捕获
    let result3 = func3_3();
    var value3 = result3(10);//10
    value3 = result3(10);//10
    print(value3);
    
    
    
  }
  
  //MARK:普通闭包 不捕获值
  func func3_1(forIncrement n:Int) -> Int {
    
    var j = 10;
    func func3_1_base() ->Int{
      return n*j;
    }
    
    return func3_1_base();
  }
  
  //MARK:用闭包捕获外部变量的引用，提升外部变量的生命周期
  func func3_2(forIncrement amount:Int)->(()->Int){
    
    var runningTotal:Int = 0;
    
    //闭包
    func incrementor() -> Int {
      runningTotal += amount;//捕获了runningTotal变量的引用 即使退出了也不会消失
      return runningTotal;
    }
    
    return incrementor;//如果返回的是函数类型，则不用加括号
  }
  
  
  //MARK:返回外部定义的函数类型 不捕获
  func func3_3_base(amount amount:Int)->Int {
    var runningTotal = 0;
    runningTotal += amount;
    return runningTotal;
  }
  
  func func3_3() -> ((Int)->Int) {
    return func3_3_base;
  }
  
  //MARK:- <用闭包定义变量的两种方式 做函数参数 做返回值>
  //MARK:- 用闭包定义变量的两种方式
  func func4_1() {
    
    let name:String = {
      return "name";
    }()
    
    let name1:()->String = {
      return "name1"
    }
    
    print("~~~\(name) \(name1())");
    
    
  }

  //MARK:- 闭包做返回值
  func funcResult5() {
    
    let result:String = func5_1()();
    print(result);
    
    let result1 = func5_2()("1",1)
    print(result1);
    
  }
  
  //返回值 简单
  func func5_1() -> (()->String) {
    
    var bb:()->String = {
      return "name1111~"
    }
    
    //或者这样
    bb = {
      ()->String in
      return "name1111~"
    }

    
    return bb;
  }
  
  //返回值 稍复杂
  func func5_2base(name name:String,age:Int) -> (reName:String,reAge:String) {
    return(name,String(age));
  }
  
  func func5_2() -> ((String,Int)->(String,String)) {
    
    var bb:(String,Int)->(String,String)
    
    bb = {
      (str:String,num:Int)->(String,String)in
      return(str,String(num));
    }
    
    //或者这样
    bb = func5_2base
    
    
    return bb;
  }
  
  //MARK:- 闭包做参数
  func func5_4Result() {
    
    let bb:(Int)->Int = {
      ( num:Int)->Int in
      return num*num;
    }
    
    let result = func5_4(bb);
    print(result);
    
  }
  
  func func5_4(block:(Int)->Int) -> Int{
    let result = block(2);
    return result;
  }
  
}




