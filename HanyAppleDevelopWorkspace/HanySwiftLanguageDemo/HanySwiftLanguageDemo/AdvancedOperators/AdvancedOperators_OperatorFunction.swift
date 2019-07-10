//
//  AdvancedOperators_OperatorFunction.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//运算符重载

import Foundation

func root_AdvancedOperators_OperatorFunction() {
  
}

//MARK:- 运算符函数（运算符重载）
//MARK:base
private func func_OperatorFunc(){
  
  let vector = Vector2D(x: 3.0, y: 1.0)
  let anotherVector = Vector2D(x: 2.0, y: 4.0)
  let combinedVector = vector + anotherVector
  print(combinedVector)// (5.0, 5.0)
  
}

//MARK:前置运算符 prefix
private func func_PrefixOperator(){
  
  let positive = Vector2D(x: 3.0, y: 4.0)
  let negative = -positive
  print(negative)// (-3,-4)
  
}

//MARK:后置运算符 postfix
private func func_PostfixOperator(){
  
  let positive = Vector2D(x: 3.0, y: 4.0)
  let negative = positive++
  print(negative)// (4,5)
  
}

//MARK:组合赋值运算符 inout
private func func_CompoundAssignmentOperators(){
  
  var original = Vector2D(x: 1.0, y: 2.0)
  let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
  original += vectorToAdd
  print(original) //(4,6)
  
}

//MARK:比较运算符
private func func_CompareOperators(){
  
  let twoThree = Vector2D(x: 2.0, y: 3.0)
  let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
  if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
  }
  
}

//MARK:自定义运算符  prefix / postfix operator
private func func_CustomOperators1(){
  
  var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
  let afterDoubling = +++toBeDoubled
  print(toBeDoubled,afterDoubling) //(2.0, 8.0)
  
}

//MARK:自定义运算符的优先级结合性 infix operator
private func func_CustomOperators2(){
  
  let firstVector = Vector2D(x: 1.0, y: 2.0)
  let secondVector = Vector2D(x: 3.0, y: 4.0)
  let plusMinusVector = firstVector +- secondVector
  print(plusMinusVector)//(4.0, -2.0)
}

//MARK:- <<< class / method >>> -
private struct Vector2D {
  var x = 0.0, y = 0.0
}

//MARK:- 运算符重载
//base
private func + (left: Vector2D, right: Vector2D) -> Vector2D {
  return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

//前置运算符
private prefix func - (vector: Vector2D) -> Vector2D {
  return Vector2D(x: -vector.x, y: -vector.y)
}

//后置运算符
private postfix func ++ (vector: Vector2D) -> Vector2D{
  
  return Vector2D(x: vector.x+1, y: vector.y+1)
}

//组合运算符
private func += (left: inout Vector2D, right: Vector2D) {
  left = left + right //用前面已经定义的+
}

//比较运算符
private func == (left: Vector2D, right: Vector2D) -> Bool {
  return (left.x == right.x) && (left.y == right.y)
}

private func != (left: Vector2D, right: Vector2D) -> Bool {
  return !(left == right)
}

//自定义运算符
prefix operator +++//必须全局声明
private prefix func +++ (vector: inout Vector2D) -> Vector2D {
  vector += vector
  return vector
}

//自定义运算符的结合性和优先级
/*
 infix标识可以指定结合性和优先级，默认值none 100
 prefix/postfix无需指定infix，默认postfix优先
 */
infix operator +-
private func +- (left: Vector2D, right: Vector2D) -> Vector2D {
  return Vector2D(x: left.x + right.x, y: left.y - right.y)
}
