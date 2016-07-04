//
//  Struct_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//MARK:- 结构体
//MARK:base 结构体是值类型
private func func2_1() {
  
  struct Point {
    
    //如果不给默认值，初始化对象时要传原始值
    var x: Double
    var y: Double
    
    //存储型 类型属性
    static let zero = Point(x: 0, y: 0)
    //计算型 类型属性
    static var ones: [Point] {
      return [Point(x: 1, y: 1),
              Point(x: -1, y: 1),
              Point(x: 1, y: -1),
              Point(x: -1, y: -1)]
    }
    
    //类方法
    static func add(p1 p1: Point, p2: Point) -> Point {
      return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    func objMethod() {
      print("static objMethod~");
    }
    
  }
  
  //结构体是值类型
  let pointA = Point(x: 10, y: 10);
  var pointB = pointA;
  pointB.x = 11;
  print(pointA,pointB);
  
  //存储型 类型属性
  print("zero:\(Point.zero)");
  
  //计算型 类型属性
  print("ones:\(Point.ones)");
  
  //方法
  let point1 = Point(x: 1, y: 1);
  let point2 = Point(x: 2, y: 2);
  
  point1.objMethod();
  
  let point = Point.add(p1:point1, p2: point2);
  print(point);
}

//MARK:mutating 变异方法
/*
 用途：在方法内部改变属性
 */
private func func2_2(){
  
  struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
      x += deltaX
      y += deltaY
    }
    
    mutating func selfByX(deltaX: Double, y deltaY: Double) {
      self = Point(x: x + deltaX, y: y + deltaY)
    }
  }
  
  var somePoint = Point(x: 1.0, y: 1.0)
  somePoint.moveByX(2.0, y: 3.0)
  print("The point is now at (\(somePoint.x), \(somePoint.y))")
  
}

//MARK:sturct 附属脚本
private func func2_3() {
  
  //简单的附属脚本
  struct Count{
    let value:Int
    subscript(index:Int)->Int{
      return index*value;
    }
  }
  
  let count = Count(value:2);
  print("\(count[3])");
  
  
  
  
  
  //附属脚本选项
  struct Matrix {
    
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
      self.rows = rows
      self.columns = columns
      grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
      return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
      get {
        assert(indexIsValidForRow(row, column: column), "Index out of range")
        return grid[(row * columns) + column]
      }
      set {
        assert(indexIsValidForRow(row, column: column), "Index out of range")
        grid[(row * columns) + column] = newValue
      }
    }
  }
  
  
  var matrix = Matrix(rows:2,columns:2);
  matrix[0,1] = 2;
  print(matrix[0,1]);
}
