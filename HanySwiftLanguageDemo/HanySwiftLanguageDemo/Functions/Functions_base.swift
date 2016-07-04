//
//  Functions_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//MARK: - <<< method >>> -
//MARK:一个简单函数
private func func1(name:String,age:Int)->String{
  
  return String("\(name),\(age)");
}

private func funcResult1(){
  let str:String = func1("Hany", age: 26);
  print(str);
}



//MARK:返回多个值 返回值是元组
private func func2(s1:String,s2:String)->(name:String,age:String)?{
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



//MARK:扩展参数与本地参数
/*
 func(扩展参数名1 本地参数名1:参数类型,扩展参数名2 本地参数名2:参数类型,...)
 func(扩展参数名1 本地参数名1:参数类型,扩展本地参数名2:参数类型,...)
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
private func func5(name name:String = "Mike",age:String)->(reName:String,reAge:String){
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
private func func6(name name:String,age:String...)->(reName:String,reAge:String){
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
private func func7(inout name name:String,inout age:String) -> String {
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
private func func8(name name:String,age:Int) -> (reName:String,reAge:String) {
  
  let result = (name,String(age));
  return result;
}

private func funcResult8(){
  
  let funcPoint8:(String,Int)->(String,String) = func8;//函数类型
  
  let result = funcPoint8("name",12);
  print(result);
}

//MARK:函数类型作为函数参数
private func funcBase9(name name:String, age:String) -> (reName:String,reAge:String) {
  let result = (name,age);
  return result;
}

private func func9(fun:(String,String)->(String,String)) {
  let result = fun("A","a");
  print(result);
}

private func funcResult9(){
  
  func9(funcBase9);
  
  func9 { (name, age) -> (String, String) in
    return (name+"!",age+"!");
  }
}

//MARK:函数类型作为函数返回值
private func funcBase10_1(n:Int) -> Int {
  return n*n;
}

private func funcBase10_2(n:Int) -> Int {
  return n*n*n;
}

private func func10(b:Bool) -> ((Int)->Int) {
  return b ? funcBase10_1 : funcBase10_2;
  
}

private func funcResult10(){
  let result = func10(false)(2);
  print(result);
}

//MARK:函数嵌套
private func func11(n:Int) -> Int {
  
  func func11_1(n:Int)->Int{
    return n*n;
  }
  
  return func11_1(n);
}

private func funcResult11(){
  let resutl = func11(2);
  print(resutl);
}
