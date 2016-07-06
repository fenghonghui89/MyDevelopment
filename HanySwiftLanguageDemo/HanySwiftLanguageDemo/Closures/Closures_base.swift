//
//  Closures_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//闭包

import Foundation

func root_Closures_base() {
  func_autoClosures()
}

//MARK:- < 推导例子 闭包的写法 尾随闭包 >
//MARK:推导例子 - 排序
private func func1() {
  
  let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
  
  var reversed:[String];
  
  //方法1：函数做参数
  func backwards(s1: String, s2: String) -> Bool {
    return s1 < s2
  }
  
  reversed = names.sort(backwards);
  
  
  
  //方法2：闭包
  reversed = names.sort({(s1: String, s2: String) -> Bool in
    return s1 > s2
  });//闭包
  
  reversed = names.sort({s1, s2 in
    return s1 > s2
  });//Inferring Type From Context(从上下文推断类型)
  
  reversed = names.sort({s1, s2 in
    s1 > s2
  });//Implicit Returns from Single-Expression Closures(单个表达式闭包可以隐式return)
  
  reversed = names.sort({
    $0 > $1
  });//Shorthand Argument Names(用速记参数名可以省略参数列表)
  
  reversed = names.sort(){
    $0 > $1
  }//Trailing Closures(尾随闭包，当最后参数是闭包时可用，把闭包放到括号后面，可以不写参数列表)
  
  reversed = names.sort{
    $0>$1
  }//如果方法只有一个闭包参数，可以把括号去掉
  
  reversed = names.sort(
    >
  );//swift字符串定义了>是作为一个函数（Operator Functions运算符重载）
  
  for i in reversed {
    print(i);
  }
}



//MARK:闭包的写法 - 转换数字为对应英文
/*
 
 
 { (parameters) -> return type in
 
 statements
 
 }
 

 */
private func func_closures() {
  
  let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
  ];
  
  let numbers = [16, 510, 58];
  
  
  let strings = numbers.map {
    (number) -> String in //参数 返回值（参数名自己定，类型系统会自己推导）
    
    //函数体
    var output = "";
    var num = number;
    while num > 0 {
      output = digitNames[num % 10]! + output;
      num /= 10;
    }
    return output;
  };
  
  print(strings);
}


//MARK:trailing闭包（尾随闭包）
private func func_trailingClosures() {
  
  //标准 fun(闭包)
  func2_1({print("~~")});
  
  //trailing闭包 fun()闭包 当函数的最后一个参数是闭包时可用
  func2_1(){print("@@@")};
  
  //无参数可以把()去掉
  func2_1{print("@@@")};
}

private func func2_1(block:()->()){
  for _ in 0...2 {
    block();
  }
}

//MARK:- < 捕获值 嵌套函数是最简单的可捕获值闭包；闭包可以在作用域外引用和修改捕获的值，因为闭包和函数是引用类型 >
private func func3_result() {
  
  
  //捕获值
  var function = func3_2_2(forIncrement: 2);//~0
  var result = function(10);//12
  result = function(10);//24
  print(result);
  
  //新的变量拥有新的引用 跟上面的不相关
  function = func3_2_2(forIncrement: 7);//~0
  result = function(7);//14
  result = function(7);//28
  print(result);
  
}


//MARK:捕获值
private func func3_2_2(forIncrement amount:Int)->((Int)->Int){
  
  var runningTotal:Int = 0;
  print("~\(runningTotal)")//只输出1次
  
  func func3_2_2_base(value:Int) -> Int {
    runningTotal += amount;//捕获runningTotal和amount的值
    runningTotal += value;
    return runningTotal;
  }
  
  return func3_2_2_base;//如果返回的是函数类型，则不用加括号
}


//MARK:- <用闭包定义变量的两种方式 做函数参数 做返回值>
//MARK:用闭包定义变量的两种方式
private func func4_1() {
  
  let name:String = {
    return "name";
  }()
  
  let name1:()->String = {//自动闭包
    return "name1"
  }
  
  print("~~~\(name) \(name1())");
  
  
}

//MARK:闭包做返回值
private func funcResult5() {
  
  let result:String = func5_1()();
  print(result);
  
  let result1 = func5_2()("1",1)
  print(result1);
  
}

//返回值 简单
private func func5_1() -> (()->String) {
  
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
private func func5_2base(name name:String,age:Int) -> (reName:String,reAge:String) {
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

//MARK:闭包做参数
private func func5_4Result() {
  
  let bb:(Int)->Int = {
    (num:Int)->Int in
    return num*num;
  }
  print(bb(5));
  
  let result = func5_4_1(bb);
  print(result);
  
  
  func5_4_2({print("hello~")});
  func5_4_2{print("~~~~")}
  
}

private func func5_4_1(block:(Int)->Int) -> Int{
  let result = block(2);
  return result;
}

private func func5_4_2(block:()->()){
  for _ in 0...2 {
    block()
  }
}

//MARK:- < @noescape >
/*
 修饰的闭包在函数结束后也会随之结束，用于告诉编译器优化性能
 
 什么情况下一个闭包参数会跳出函数的生命期呢？
 很简单，我们在函数实现内，将一个闭包用 dispatch_async嵌套，这样这个闭包就会在另外一个线程中存在，从而跳出了当前函数的生命期。
 这样做主要是可以帮助编译器做性能的优化。
 */
private func func_noescape() {
  
  let instance = SomeClass()
  
  instance.doSomething()
  print(instance.x)
  // Prints "200"
  
  completionHandlers.first?()
  print(instance.x)
  // Prints "100"
  
}

//MARK:- < 自动闭包 @autoclosure @autoclosure(escaping) >
//自动闭包 @autoclosure
private func func_autoClosures(){
  
  var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
  print(customersInLine.count)
  // Prints "5"
  
  //定义一个自动闭包
  let customerProvider = {
    return customersInLine.removeAtIndex(0)
  }
  //相当于
  //    let customerProvider:()->String = {
  //      return customersInLine.removeAtIndex(0)
  //    }
  
  print(customersInLine.count)
  // Prints "5"
  
  //自动闭包
  print("Now serving \(customerProvider())!")
  // Prints "Now serving Chris!"
  
  print(customersInLine.count)
  // Prints "4"
  
  
  //显示闭包
  // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
  func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
  }
  
  serve(customer: {
    customersInLine.removeAtIndex(0)
  })
  // Prints "Now serving Alex!"
  

  //@autoclosure（标识后可以不用写大括号，尽量少用，因为可能会使逻辑难以理解）
//  // customersInLine is ["Ewa", "Barry", "Daniella"]
//  func serve(customer customerProvider: @autoclosure () -> String) {
//    print("Now serving \(customerProvider())!")
//  }
//  serve(customer: customersInLine.removeAtIndex(0))
//  // Prints "Now serving Ewa!"

}

//@autoclosure(escaping) 未看得明。。。


//MARK:- ****************************** class ******************************


private func someFunctionWithNonescapingClosure(@noescape closure: () -> Void) {
  closure()
}

var completionHandlers: [() -> Void] = []
private func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
  completionHandlers.append(completionHandler)
}

class SomeClass {
  
  var x = 10
  
  func doSomething() {
    someFunctionWithNonescapingClosure { x = 200 }//用@noescape标识闭包 可以隐式引用self
    someFunctionWithEscapingClosure { self.x = 100 }
  }
}
