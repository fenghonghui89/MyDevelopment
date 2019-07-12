//
//  Functions_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//函数

import Foundation

func root_Functions_base() {
    funcResult10();
}

//MARK: - <<< method >>> -
//MARK:一个简单函数
private func func1(_ name:String,age:Int)->String{
    
    return String("\(name),\(age)");
}

private func funcResult1(){
    let str:String = func1("Hany", age: 26);
    print(str);
}



//MARK:返回多个值 返回值是元组
private func func2(_ s1:String,s2:String)->(name:String,age:String)?{
    if (s1 == "" || s2 == "") {
        return nil;
    }
    let result = (s1,s2);
    return result;
}

private func funcResult2(){
    if let result = func2("Hany", s2: "Salar"){
        print(result.name,result.age);
    }
}



//MARK:参数标签与参数名
/*
 参数标签在前 参数名在后
 参数标签-调用时显示 参数名-函数内部用
 默认参数标签跟参数名一样
 */
private func func3(name s1:String,age s2:String)->(name:String,age:String){
    let result = (s1,s2);
    return result;
}

private func funcResult3(){
    let result = func3(name: "Hany", age: "sb");
    print(result.name,result.age);
    
}


//MARK:函数默认值
private func func5(name:String = "Mike",age:String)->(reName:String,reAge:String){
    let resutl = (name,age);
    return resutl;
}

private func funcResult5(){
    let result = func5(name: "Hany", age: "Salar");
    print(result.reName,result.reAge);
    
    let result1 = func5(age: "Hany");
    print(result1.reName,result1.reAge);
}

//MARK:允许其中一个参数传多个值
private func func6(name:String,age:String...)->(reName:String,reAge:String){
    for value in age {
        print(value);
    }
    
    let result = (name,age[0]);
    return result;
}

private func funcResult6() {
    let result = func6(name: "Hany", age: "Ann","Mary");
    print(result.reName,result.reAge);
}

//MARK:inout - 可在函数内改变参数值再输出
private func func7(name:inout String,age:inout String) -> String {
    name = "Mike";
    age = "12"
    let reName:String = String(name+" "+age+"ok");
    return reName;
}

private func funcResult7(){
    var name:String = "Hany";
    var age:String = "12"
    let result = func7(name: &name,age: &age);
    print(result);
}

//MARK:函数类型 类似于函数指针 其实就是闭包
private func func8(name:String,age:Int) -> (reName:String,reAge:String) {
    
    let result = (name,String(age));
    return result;
}

private func funcResult8(){
    
    let funcPoint8:(String,Int)->(String,String) = func8;//函数类型
    
    let result = funcPoint8("name",12);
    let result1 = func8(name: "name", age: 12);
    print(result,result1);
}

//MARK:函数类型作为函数参数
private func funcBase9(name:String, age:String) -> (reName:String,reAge:String) {
    let result = (name,age);
    return result;
}

private func func9(fun:(String,String)->(String,String)) {
    let result = fun("A","a");
    print(result);
}

private func funcResult9(){
    
    func9(fun:funcBase9);
    
    func9(fun:funcBase9(name:age:));
    
    func9 { (name, age) -> (String, String) in
        return (name+"!",age+"!");
    }
    
    
}

//MARK:函数类型作为函数返回值
private func funcBase10_1(n:Int) -> Int {
    return n*n;
}

private func funcBase10_2 (n:Int) -> Int {
    return n*n*n;
}

private func func10(b:Bool) -> ((Int)->Int) {
    return b ? funcBase10_1 : funcBase10_2;
    
}

private func funcResult10(){
    let result = func10(b:false)(2);
    
    let r = func10(b: false);
    let i:Int = r(2);
    
    print(result,i);
}

//MARK:函数嵌套
private func func11(n:Int) -> Int {
    
    func func11_1(y:Int)->Int{
        return n*n;
    }
    
    return func11_1(y: n);
}

private func funcResult11(){
    let resutl = func11(n:2);
    print(resutl);
}
