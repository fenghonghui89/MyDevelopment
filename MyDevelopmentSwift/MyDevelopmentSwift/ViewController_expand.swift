//
//  ViewController_expand.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/26.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_expand: UIViewController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad();
    
    func5();
  }
  
  //MARK:- <<< method >>>
  //MARK:扩展Double
  func func1() {
    
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")// 打印输出："One inch is 0.0254 meters"
    
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")// 打印输出："Three feet is 0.914399970739201 meters"
    
    let aMarathon = 42.km + 195.m
    print("A marathon is \(aMarathon) meters long")// 打印输出："A marathon is 42495.0 meters long"
  }
  
  //MARK:扩展构造器
  func func2(){
    
    let defaultRect = Rect()
    let memberwiseRect = Rect(origin: Point(x: 1, y: 1),size:Size(width: 2, height: 2))
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),size: Size(width: 3.0, height: 3.0))// centerRect的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
  }
  
  //MARK:扩展方法
  func func3(){
    
    var i:Int = 4;
    
    let block = {
      print("~~!");
    }
    
    i.repetitions(block);
    i.repetitions({
      print("hello")}
    );
    i.repetitions{print("!!!!")};
  }
  
  //MARK:修改实例
  func func4() {
    
    var value:Int = 3;
    value.square1();
    print(value);
    
  }
  
  //MARK:扩展下标
  func func5() {
    
    let i:Int = 1234567;
    print(i[2]);//输出从右往左数第n-1个数字
    
  }
}


//MARK:- <<< class >>>
//MARK:扩展Double
extension Double{

  var km: Double { return self * 1_000.0 }
  var m : Double { return self }
  var cm: Double { return self / 100.0 }
  var mm: Double { return self / 1_000.0 }
  var ft: Double { return self / 3.28084 }
}

//MARK:扩展构造器

struct Size {
  var width = 0.0, height = 0.0
}

struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
}

extension Rect {
  
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}

//MARK:扩展方法
extension Int{

  func repetitions(task:()->()){
    for _ in 0...self {
      task();
    }
  }
}

//MARK:修改实例 - mutating
extension Int{

  mutating func square1(){
    self = self*self;
  }
}




//MARK:扩展下标 - subscript
extension Int {
  
  subscript(digitIndex: Int) -> Int {
    
    var decimalBase = 1
    
    if digitIndex == 0{
      return self % 10
    }
    
    for _ in 1...digitIndex {
      decimalBase *= 10
    }
    return (self / decimalBase) % 10
  }
}


