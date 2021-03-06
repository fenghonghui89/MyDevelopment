//
//  Generics_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//泛型

import Foundation

func root_Generics_base() {
  
}
//MARK:- <<< method >>>
//MARK:泛型函数 func<Element>(a.b)
private func func_GenericFunctions(){
  
  var someInt = 3
  var anotherInt = 107
  swapTwoValues(&someInt, &anotherInt)//调用泛型函数无需指定类型
  // someInt is now 107, and anotherInt is now 3
  
  var someString = "hello"
  var anotherString = "world"
  swapTwoValues(&someString, &anotherString)
  // someString is now "world", and anotherString is now "hello"
  
  
}

private func swapTwoValues<T>(_ a: inout T, _ b: inout T) {//inout修改参数值
  let temporaryA = a
  a = b
  b = temporaryA
  
}

//MARK:泛型类型
private func func_GenericTypes() {
  
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
private func func_ExtendingAGenericType() {
  
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
private func func_TypeConstraints(){
  
  let arr = ["one","two","three"]
  
  let index = findIndex(arr, valueToFound: "two")
  print("the result index is \(index)")
  
  
  
  
  let doubleIndex = findIndex([3.14159, 0.1, 0.25], valueToFound: 9.3)
  // doubleIndex is an optional Int with no value, because 9.3 is not in the array
  let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], valueToFound: "Andrea")
  // stringIndex is an optional Int containing a value of 2
  
  
}

/*
 Equatable协议规定类型都能用==、!=判断
 */
private func findIndex<T:Equatable>(_ array:[T],valueToFound:T) -> Int? {
  for (index,value) in array.enumerated(){
    if value == valueToFound {
      return index
    }
  }
  
  return nil;
}

//MARK:关联类型 associatedtype
private func func_AssociatedTypes(){
  
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
private func func_WhereClauses(){
  
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


private func allItemsMatch<
  C1: Container, C2: Container>
  (_ someContainer: C1, _ anotherContainer: C2) -> Bool
  where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
  
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


//MARK:- <<< class / protocol >>>

//非泛型类型struct
private struct IntStack: Container {
  
  //非泛型类型
  var items = [Int]()
  mutating func push(_ item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
  
  //关联类型
  typealias ItemType = Int
  mutating func append(_ item: Int) {
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
private struct Stack<T>: Container {
  
  //泛型类型
  var items = [T]()
  mutating func push(_ item: T) {
    items.append(item)
  }
  mutating func pop() -> T {
    return items.removeLast()
  }
  
  //关联类型 associatedtype
  mutating func append(_ item: T) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> T {
    return items[i]
  }
  
}



private extension Stack {
  var topItem: T? {
    return items.isEmpty ? nil : items[items.count - 1]
  }
}





private protocol Container {
  
  associatedtype ItemType
  mutating func append(_ item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}


//MARK:- 例子
/*
 泛型不支持非对象类型
 */
private func swapTwoValues<T:testClass>(_ a: T, _ b: T)->Int where T:testProtocol1 {
    return 1;
}

protocol testProtocol1:NSObjectProtocol {
    func value1() -> Int
}

protocol testProtocol2:NSObjectProtocol {
    func value1() -> Int
}


class testClass: NSObject {
    
}
