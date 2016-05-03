//
//  ViewController_generic.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/3.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_generic: UIViewController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad();
    
    funcResult4();
  }
  
  //MARK:- <<< method >>>
  //MARK:泛型函数
  func funcResult1(){
    
    var i = "a";
    var j = "b";
    
    swapTwoValues(&i, b: &j);//调用泛型函数无需指定类型
    print("i:\(i),j:\(j)")
    
  }
  
  func swapTwoValues<T>(inout a: T, inout b: T) {//inout修改参数值
    let temporaryA = a
    a = b
    b = temporaryA
  }
  
  //MARK:泛型类型
  func funcResult2() {
    
    var st = Stack<String>()
    st.push("one")
    st.push("two")
    st.push("three")
    
    for value in st.items {
      print("1:\(value)")
    }
    
    let result = st.pop()
    print("the lest is \(result)")
    
  }
  
  //MARK:类型约束
  func funcResult3(){
    
    let arr = ["one","two","three"]
    
    let index = findIndex(arr, valueToFound: "two")
    print("the result index is \(index)")
  }
  
  /*
   Equatable协议规定类型都能用==、!=判断
   */
  func findIndex<T:Equatable>(array:[T],valueToFound:T) -> Int? {
    for (index,value) in array.enumerate(){
      if value == valueToFound {
        return index
      }
    }
    
    return nil;
  }
  
  //MARK:关联类型
  func funcResult4(){
    
    var st = Stack<String>()
    st.append("one")
    st.append("two")
    st.append("three")
    
    print("count:\(st.count)")

    for index in 0...st.count-1 {
      print(st[index])
    }
  }
}

//MARK:- <<< class / protocol >>>

struct Stack<Element>: Container {
  
  //泛型类型
  var items = [Element]()
  mutating func push(item: Element) {
    items.append(item)
  }
  mutating func pop() -> Element {
    return items.removeLast()
  }
  
  //关联类型
  mutating func append(item: Element) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Element {
    return items[i]
  }
}


protocol Container {
  associatedtype ItemType
  mutating func append(item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}

