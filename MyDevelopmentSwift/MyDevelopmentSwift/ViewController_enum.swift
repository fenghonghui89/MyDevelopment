//
//  ViewController_enum.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/18.
//  Copyright © 2016年 MD. All rights reserved.
//


import UIKit


class ViewController_enum: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    func1_4();
  }
  
  
  //MARK:- <<< method >>>
  //MARK:- 枚举
  //MARK:base 枚举是值类型
  func func1_1() {
    
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
    
    enum Point{
      case East,South,West,North
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
  func func1_2() {
    
    enum Barcode{
      case UPCA(Int,Int,Int);
      case QRCode(String);
    }
    
    var productBarcode = Barcode.UPCA(1, 2, 3);
    productBarcode = .QRCode("abc");//只能保留一个
    
    switch productBarcode {
    case let .UPCA(numberSystem, identifier, check):
      print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
    case let .QRCode(productCode):
      print("QR code with value of \(productCode).")
    }
    
  }
  
  //MARK:定义每个成员的类型和原始值 原始值与成员的相互关联
  func func1_3(){
    
    //enum的类型 默认值
    enum Human:String{
      case name = "default name";
      case age = "default age";
      case sex = "default sex";
    }
    
    let Tom = Human.sex.rawValue;
    print(Tom);
    
    //如果是整形，没有定义原始值的成员默认自增长
    enum CustomNumTag:Int{
      case One = 1,Two,Three,Four;
    }
    
    let num = CustomNumTag.Four.rawValue;
    print(num);
    
    //通过原始值获取对应成员 获取不成功返回nil
    let num1 = CustomNumTag.init(rawValue: 5);
    switch num1 {
    case is CustomNumTag:
      print("yes");
    case nil:
      print("nil");
    default:
      print("no");
    }
    
    //不能用switch？
    if num1 == CustomNumTag.Four {
      print("is 4");
    }else if num1 == nil{
      print("is nil");
    }else{
      print("is not 4");
    }
    
  }
  
  //MARK:enum 变异方法
  func func1_4() {
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
  
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}



