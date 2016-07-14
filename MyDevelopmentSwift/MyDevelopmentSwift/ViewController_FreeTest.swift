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

    
  }
}



class MyView: UIView {
  
  init(flag:Bool){
    
    super.init(frame: CGRectZero)
    
    if flag {
      print("yes")
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class MyVC: UIViewController {
  
  init(flag:Bool){
  
    super.init(nibName: nil, bundle: nil)
    if flag {
      print("yes")
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class MyAC: UIAlertController {
  
 
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class BasePC {
  
  private var cpu_count:Int
  
  var level:Int{
    get{
      print("cup count:\(self.cpu_count)")
      return self.cpu_count
    }
  }
  
  private init(cpu_count:Int){
    self.cpu_count = cpu_count
  }
  
  convenience init(level:Int){
    self.init(cpu_count: level)
  }
  
}

