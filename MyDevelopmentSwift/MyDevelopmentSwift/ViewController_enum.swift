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
    
    func3();
  }
  
  
  //MARK:- <<< method >>>
  //MARK:定义枚举 赋值
  func func1() {
    
    enum CompassPoint{
      case East
      case South
      case West
      case North
      
    }
    
    enum Point{
      case East,South,West,North
    }
    
    var dest = CompassPoint.East;
    dest = .North;
    
    switch dest {
    case .East:
      print("\(dest) this is east");
    default:
      print("\(dest) this is no east");
    }
  }
  
  //MARK:关联值
  func func2() {
    
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
  func func3(){
    
    //原始值
    enum Person:String{
      case name = "default name";
      case age = "default age";
      case sex = "default sex";
    }
    
    let Tom = Person.sex.rawValue;
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
  
  
  
}