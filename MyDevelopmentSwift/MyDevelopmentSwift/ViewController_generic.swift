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
    
    funcGenericExpend();
  }
  
  //MARK:- <<< method >>>
  //MARK:泛型函数 func<Element>(a.b)
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
  
  //MARK:扩展泛型类型
  func funcGenericExpend() {
    
    var st = Stack<String>()
    st.append("1")
    st.pop()
    
    if let topItem = st.topItem{
      print("the top item is \(topItem)")
    }else{
      print("the top item is nil")
    }
  }
  
  //MARK:类型约束 func<Element:Protocol>(a,b)
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
  
  //MARK:关联类型 associatedtype
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
  
  //MARK:类型约束+where语句
  func funcResult5(){
    
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("1")
    stackOfStrings.push("2")
    stackOfStrings.push("3")
    
    var stackOfStrings1 = Stack<String>()
    stackOfStrings1.push("1")
    stackOfStrings1.push("2")
    stackOfStrings1.push("3")
    stackOfStrings1.push("4")

    if allItemsMatch(stackOfStrings, stackOfStrings1) {
      print("All items match.")
    } else {
      print("Not all items match.")
    }

  }
  
  
  func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
      return false
    }
    
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
      if someContainer[i] != anotherContainer[i] {
        return false
      }
    }
    
    // all items match, so return true
    return true
    
  }
  
}

//MARK:- <<< class / protocol >>>

//非泛型类型struct
struct IntStack: Container {
  
  //非泛型类型
  var items = [Int]()
  mutating func push(item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
  
  //关联类型
  typealias ItemType = Int
  mutating func append(item: Int) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Int {
    return items[i]
  }
}

//泛型类型struct
struct Stack<T>: Container {
  
  //泛型类型
  var items = [T]()
  mutating func push(item: T) {
    items.append(item)
  }
  mutating func pop() -> T {
    return items.removeLast()
  }
  
  //关联类型 associatedtype
  mutating func append(item: T) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> T {
    return items[i]
  }
  
}



extension Stack {
  var topItem: T? {
    return items.isEmpty ? nil : items[items.count - 1]
  }
}





protocol Container {
  
  associatedtype ItemType
  mutating func append(item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}

