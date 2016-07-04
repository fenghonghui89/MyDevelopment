//
//  Enumerations_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//MARK:- ****************************** method ******************************
//MARK:枚举语法
private func func_EnumerationSyntax(){
  
  enum CompassPoint {
    case North
    case South
    case East
    case West
  }
  
  
  
  enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
  }
  
  
  
  var directionToHead = CompassPoint.West
  directionToHead = .East
  
  
}

//MARK:枚举是值类型 用switch匹配枚举值
private func func_MatchingEnumerationValueswithASwitchStatement() {
  
  //定义
  enum CompassPoint{
    
    case East
    case South
    case West
    case North
    
    //存储型 类型属性
    static var None2:Int = 2
    
    //计算型 类型属性
    static var None: Int {
      return 111
    }
    
    //方法
    func objMethod(){
      print("enum objMethod~");
    }
    
    static func classMethod(){
      print("enum classMethod~");
    }
    
  }
  
  //赋值
  var dest = CompassPoint.East;
  dest = .North;
  print("enum 类型属性：\(CompassPoint.None2)");
  dest.objMethod();
  CompassPoint.classMethod();
  
  //判断
  switch dest {
  case .East:
    print("\(dest) this is east");
  default:
    print("\(dest) this is no east");
  }
  
  //枚举是值类型
  var bdest = dest;
  bdest = .South;
  print(dest,bdest);
}

//MARK:关联值
private func func_AssociatedValues() {
  
  enum Barcode{
    case UPCA(Int,Int,Int);
    case QRCode(String);
  }
  
  var productBarcode = Barcode.UPCA(1, 2, 3);
  productBarcode = .QRCode("abc");//只能保留一个，所以会替换上面的
  
  switch productBarcode {
  case let .UPCA(numberSystem, identifier, check):
    print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
  case let .QRCode(productCode):
    print("QR code with value of \(productCode).")
  }
  
}

//MARK:定义每个成员的类型和原始值 原始值与成员的相互关联
private func func_RawValues(){
  
  //enum的类型 默认值
  enum Human:String{
    case name = "default name";
    case age = "default age";
    case sex = "default sex";
  }
  
  let Tom = Human.sex.rawValue;
  print(Tom);
  
  
  //如果枚举类型是String，则默认值是元素本身
  enum CompassPoint: String {
    case North, South, East, West
  }
  
  print("CompassPoint value:\(CompassPoint.North.rawValue)");
  
  //如果是整形，没有定义原始值的成员默认自增长
  enum CustomNumTag:Int{
    case One = 1,Two,Three,Four;
  }
  
  let num = CustomNumTag.Four.rawValue;
  print(num);
  
  //通过原始值获取对应成员 获取不成功返回nil
  let num1 = CustomNumTag.init(rawValue: 3);
  switch num1! {//必须用可选值的强制解析
  case .One:
    print("1:\(CustomNumTag.One.rawValue)");
  case .Two:
    print("2:\(CustomNumTag.Two.rawValue)");
  case .Three:
    print("3:\(CustomNumTag.Three.rawValue)");
  case .Four:
    print("4:\(CustomNumTag.Four.rawValue)");
  }
  
  //用可选值的绑定来做
  if let num2 = CustomNumTag(rawValue:5){
    switch num2 {
    case .One:
      print("~1:\(CustomNumTag.One.rawValue)");
    case .Two:
      print("~2:\(CustomNumTag.Two.rawValue)");
    case .Three:
      print("~3:\(CustomNumTag.Three.rawValue)");
    case .Four:
      print("~4:\(CustomNumTag.Four.rawValue)");
    }
  }else{
    print("is nill..");
  }
  
  
  
  
}



//MARK:indirect 用于枚举的递归计算
private func func_RecursiveEnumerations() {
  
  
  enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
  }
  
  
  
  let five = ArithmeticExpression.Number(5)
  let four = ArithmeticExpression.Number(4)
  let sum = ArithmeticExpression.Addition(five, four)
  let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
  print(product);
  
  
  func evaluate(expression: ArithmeticExpression) -> Int {
    
    switch expression {
    case let .Number(value):
      return value
    case let .Addition(left, right):
      return evaluate(left) + evaluate(right)
    case let .Multiplication(left, right):
      return evaluate(left) * evaluate(right)
    }
  }
  
  print(evaluate(product))
  // Prints "18" 上面三个return都会触发
  
  
}


//MARK:mutating 变异方法
private func func1_4() {
  enum TriStateSwitch {
    case Off, Low, High ;
    mutating func next() {
      switch self {
      case Off:
        self = Low
      case Low:
        self = High
      case High:
        self = Off
      }
    }
  }
  var ovenLight = TriStateSwitch.Low
  ovenLight.next()
  ovenLight.next()
  print(ovenLight);
  
  
  
}
