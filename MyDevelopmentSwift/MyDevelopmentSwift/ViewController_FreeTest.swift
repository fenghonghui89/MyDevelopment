//
//  ViewController_FreeTest.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/13.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_FreeTest: UIViewController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad();
//    let scl:SuperClass = SuperClass(par1: "", par2: "")
//    let myTableView: UITableView = UITableView(frame: CGRectZero, style: .Grouped)
//    let color = UIColor(red: 1, green: 1, blue: 1, alpha: 1);
//    let tf = UITextField(frame: CGRectZero)
//    tf.backgroundColor = UIColor.darkGrayColor();
//    
//    let data:AnyObject = NSDate()
//    let f = data.dateByAddingTimeInterval?(10)
//    data.characterAtIndex?(5)
//    // crash, myObject does't respond to that method
//    if let ff = data.characterAtIndex?(5) {
//      print("\(ff)");
//    }else{
//      print("nil..")
//    }
//    
//    let mydata = f as! NSDate;
//    mydata.timeIntervalSinceNow;
    
    let obj = TestClass();
    obj.blockTest();
    
  }
}



class TestClass {
  
  var name:String = "";
  
  var block:(value:Int)->String = {
    (num)->String in
    return String(num)
  };
  
  init(){
    block = {
     (value)->String in
      return String(value)
    }
  }
  
  func blockTest() {
    self.block = {
      [unowned self](age)->String in
      self.name = String(age)
      return self.name
    }
  }
  
  deinit{
    print("deinit...");
  }
}

