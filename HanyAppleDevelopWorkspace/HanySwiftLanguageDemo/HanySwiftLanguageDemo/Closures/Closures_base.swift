//
//  Closures_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//闭包

import Foundation

func root_Closures_base() {
    kl_blockParama()
}

//MARK:- < 推导例子 闭包的写法 尾随闭包 >
//MARK:- 推导例子 - 排序
private func func1() {
    
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
    
    var reversed:[String];
    
    //方法1：函数做参数
    func backwards(s1: String, s2: String) -> Bool {
        return s1 < s2
    }
    reversed = names.sorted(by: backwards);
    
    //方法2：闭包
    reversed = names.sorted(by: {(s1: String, s2: String) -> Bool in
        return s1 > s2
    });//闭包
    
    reversed = names.sorted(by: {s1, s2 in
        return s1 > s2
    });//Inferring Type From Context(从上下文推断类型)
    
    reversed = names.sorted(by: {s1, s2 in
        s1 > s2
    });//Implicit Returns from Single-Expression Closures(单个表达式闭包可以隐式return)
    
    reversed = names.sorted(by: {
        $0 > $1
    });//Shorthand Argument Names(用速记参数名可以省略参数列表)
    
    reversed = names.sorted(){
        $0 > $1
    }//Trailing Closures(尾随闭包，当最后参数是闭包时可用，把闭包放到括号后面，可以不写参数列表)
    
    reversed = names.sorted{
        $0>$1
    }//如果方法只有一个闭包参数，可以把括号去掉
    
    reversed = names.sorted(
        by: >
    );//swift字符串定义了>是作为一个函数（Operator Functions运算符重载）
    
    for i in reversed {
        print(i);
    }
}



//MARK:- 闭包的写法 - 转换数字为对应英文
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
    
    
    let strings = numbers.map { (number) -> String in //参数 返回值（参数名自己定，类型系统会自己推导）
        
        //函数体
        var output = "";
        var num = number;//用临时变量方便修改
        while num > 0 {
            output = digitNames[num % 10]! + output;
            num /= 10;
        }
        return output;
    };
    
    print(strings);
}


//MARK:- trailing闭包（尾随闭包）
private func func_trailingClosures() {
    
    //标准 fun(闭包)
    func2_1(block:{print("~~")});
    
    //trailing闭包 fun()闭包 当函数的最后一个参数是闭包时可用
    func2_1(){
        print("@@@")
    };
    
    //无参数可以把()去掉
    func2_1{
        print("@@@");
    };
}

private func func2_1(block:()->()){
    for _ in 0...2 {
        block();
    }
}

//MARK:- < 捕获值 嵌套函数是最简单的可捕获值闭包；闭包可以在作用域外引用和修改捕获的值，因为闭包和函数是引用类型 >
private func func3_result() {
    
    
    //捕获值
    var function = func3_2_2(amount: 2);//~0
    var result = function(10);//12=0+2+10
    result = function(10);//24=12+2+10
    print(result);
    
    //新的变量拥有新的引用 跟上面的不相关
    function = func3_2_2(amount: 7);//~0
    result = function(7);//14=0+7+7
    result = function(7);//28=14+7+7
    print(result);
    
}

private func func3_2_2(amount:Int)->((Int)->Int){
    
    var runningTotal:Int = 0;
    print("~\(runningTotal)")//只输出1次
    
    func func3_2_2_base(value:Int) -> Int {
        runningTotal += amount;//捕获runningTotal和amount的值
        runningTotal += value;
        return runningTotal;
    }
    
    return func3_2_2_base;//如果返回的是函数类型，则不用加括号
}


//MARK:- <用闭包定义变量的两种方式 做函数参数 做返回值 做属性>
//MARK:- 用闭包定义变量的两种方式
private func func4_1() {
    
    let name:String = {
        return "name";
    }()
    
    let name1:()->String = {//自动闭包
        return "name1"
    }
    
    let name2 = {//自动闭包
        return "name2"
    }
    
    print("~~~\(name) \(name1()) \(name2)");
    
    
}

//MARK:- 闭包做返回值
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
    bb = {()->String in
        return "name1111~"
    }
    
    
    return bb;
}

//返回值 稍复杂
func func5_2() -> ((String,Int)->(String,String)) {
    
    var bb:(String,Int)->(String,String)
    bb = {(str:String,num:Int)->(String,String)in
        return(str,String(num));
    }
    
    //或者这样
    bb = func5_2base
    
    
    return bb;
}

private func func5_2base(name:String,age:Int) -> (reName:String,reAge:String) {
    return(name,String(age));
}

//MARK:- 闭包做参数
private func func5_4Result() {
    
    let bb:(Int)->Int = {(num:Int)->Int in
        return num*num;
    }
    print(bb(5));
    
    let result = func5_4_1(block:bb);
    print(result);
    
    
    func5_4_2(block:{print("hello~")});
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

//MARK:- 闭包做属性
private func kl_blockParama(){
    
    let ftc = FTC()
    
    //eg1
    //  ftc.block = {
    //    (value:Int)->Void in
    //    print("值:\(value)")
    //  }
    
    //eg2
    //  ftc.block1 = {
    //    (flag:Bool,block:rootblock)->String in
    //
    //    print("值:\(flag)")
    //    block(value: 13)
    //    return "a"
    //  }
    //
    //  ftc.blocktest()
    
    //eg3
    ftc.block1!(true,{(value:Int)->Void in
        print("value:\(value)")
    })
    
    //eg3 尾随闭包形式
    ftc.block1!(true){(value:Int)->Void in
        print("value:\(value)")
    }
}

//MARK:- < @noescape 非逃逸闭包(已废弃) @escaping 逃逸闭包 @autoclosure 自动闭包 >
/*
 @noescape 非逃逸闭包
 当闭包作为参数传递进函数时，如果这个闭包只在函数中被使用，则开发者可以将这个闭包声明成非逃逸的，即告诉系统当此函数结束后，这个闭包的生命周期也将结束，这样做的好处是可以提高代码性能，将闭包声明成非逃逸的类型使用@noescape关键。
 
 @escaping 逃逸闭包
 逃逸的闭包常用于异步的操作，这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。例如这个闭包是异步处理一个网络请求，只有当请求结束后，闭包的生命周期才结束。当闭包作为函数的参数传入时，很有可能这个闭包在函数返回之后才会被执行。
 对于可以逃逸的闭包参数，其实现内部必须显式使用 self 引用，而非逃逸闭包参数则可以隐式使用 self 引用。
 
 @autoclosure 自动闭包
 (1)默认非逃逸
 (2)闭包也可以被自动的生成，这种闭包被称为自动闭包，自动闭包自动将表达式封装成闭包。
 (3)自动闭包不接收任何参数，被调用时会返回被包装在其中的表达式的值。
 (4)当闭包作为函数参数时，可以将参数标记 @autoclosure 来接收自动闭包。
 (5)自动闭包能够延迟求值,因为代码段不会被执行直到你调用这个闭包。
 (6)自动闭包默认是非逃逸的，如果要使用逃逸的闭包，需要手动声明: @autoclosure @escaping
 @autoclosure 并不支持带有输入参数的写法，也就是说只有形如 () -> T 的参数才能使用这个特性进行简化。另外因为调用者往往很容易忽视 @autoclosure 这个特性，所以在写接受 @autoclosure 的方法时还请特别小心，如果在容易产生歧义或者误解的时候，还是使用完整的闭包写法会比较好。
 
 */


//MARK:@escaping 逃逸闭包
private func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

var completionHandlers: [() -> Void] = []
private func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    //eg.网络回调
    completionHandlers.append(completionHandler)
}

private class SomeClass {
    
    var x = 10
    
    func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }//默认是noescape标识闭包 可以隐式引用self
        someFunctionWithEscapingClosure { self.x = 100 }//逃逸闭包内部必须显式调用self
    }
    
    
}

//MARK:@autoclosure 自动闭包
private func func_autoClosures(){
    
    var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    print(customersInLine.count)
    // Prints "5"
    
    //定义一个自动闭包
    let customerProvider = {
        return customersInLine.remove(at: 0)
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
    
    
    
    
    //显式闭包
    // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
    func serve(customer: () -> String) {
        print("Now serving \(customer())!")
    }
    
    serve(customer: {
        customersInLine.remove(at: 0)
    })
    // Prints "Now serving Alex!"
    
    
    
    
    //@autoclosure
    // customersInLine is ["Ewa", "Barry", "Daniella"]
    func serve1(customer: @autoclosure () -> String) {
        print("Now serving \(customer())!")
    }
    serve1(customer: "hhhh~");
    // Prints "hhhh~"
    
}




//MARK:- ****************************** class ******************************
//闭包做属性
private typealias rootblock = (_ value:Int)->Void
private typealias myblock = (_ value:Bool,_ block:rootblock)->String

private class FTC{
    
    var block:rootblock?
    var block1:myblock?
    
    //eg3
    init(){
        self.block1 = {(flag:Bool,block:rootblock)->String in
            print("值:\(flag)")
            block(13)
            return "a"
        }
        
    }
    
    func blocktest() {
        
        //eg1
        //    self.block!(value: 12);
        
        
        //eg2
        let str = self.block1!(true,
                               {(value:Int)->Void in
                                print("value:\(value)")
        });
        print("str:\(str)")
    }
}
