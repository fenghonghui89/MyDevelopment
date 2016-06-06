//
//  ViewController_WorkingWithCocoaDataTypes.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation
import UIKit

class ViewController_WorkingWithCocoaDataTypes: UIViewController {
  
  override func viewDidLoad() {
    func_array();
  }
  
  
  //MARK:String
  func func_String(){
    
    let greeting = "hello, world!"
    let capitalizedGreeting = greeting.capitalizedString
    // capitalizedGreeting: String = Hello, World!
    
    
    let myString: NSString = "123"
    if let integerValue = Int(myString as String) {
      print("\(myString) is the integer \(integerValue)")
    }
    // Prints "123 is the integer 123"
  }
  
  //MARK:本地化
  func func_Localization() {
    
    
    let format = NSLocalizedString("Hello, %@!", comment: "Hello, {given name}!")
    let name = "Mei"
    let greeting = String(format: format, arguments: [name])
    print(greeting)
    // Prints "Hello, Mei!"
    
    
    if let path = NSBundle.mainBundle().pathForResource("Localization", ofType: "strings", inDirectory: nil, forLocalization: "ja"),
      let bundle = NSBundle(path: path) {
      let translation = NSLocalizedString("Hello", bundle: bundle, comment: "")
      print(translation)
    }
    // Prints "こんにちは"
    
  }
  
  //MARK:Number
  func func_Number(){
    
    let n = 42
    let m: NSNumber = n
  }
  
  
  //MARK: Collection Classes 以数组为例，set、dic类似
  func func_array() {
    
    
    let foundationArray:NSArray = ["1","2"];
    
    let swiftArray = foundationArray as [AnyObject]
    if let downcastedSwiftArray = swiftArray as? [UIView] {
      // downcastedSwiftArray contains only UIView objects
    }
    
//    for view in foundationArray as! [UIView] {
//      // view is of type UIView
//    }
    
    let schoolSupplies: NSArray = ["Pencil", "Eraser", "Notebook"]
    // schoolSupplies is an NSArray object containing NSString objects
    print(schoolSupplies);
    
    
    let arr = [1,2,"2"];
    if let b = arr as? NSArray {
      print("yes \(b)")
    }else{
      print("no");
    }
  }

  //MARK:Foundation Data Types - CGSize CGRect...
  func func_FoundationDataTypes() {
    
    let size = CGSize(width: 20, height: 40)
    
    let rect = CGRect(x: 50, y: 50, width: 100, height: 100)
    let width = rect.width    // equivalent of CGRectGetWidth(rect)
    let maxX = rect.maxY      // equivalent of CGRectGetMaxY(rect)
    

  }
  
  //MARK:Foundation Functions - NSLog
  func func_FoundationFunctions() {
    
    NSLog("%.7f", M_PI)
    // Logs "3.1415927" to the console
    
  }
  
  //MARK:Core Foundation
  func func_CoreFoundation() {
    
  }
  
}




//MARK:Error ErrorType与NSError互操作性
@objc public enum CustomError: Int, ErrorType {
  case A, B, C
}

