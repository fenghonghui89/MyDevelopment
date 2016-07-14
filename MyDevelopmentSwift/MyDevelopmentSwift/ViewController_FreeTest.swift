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

class AAA {
  
  private var cpu:Int
  
  var type:Int{
    get{
      return self.cpu
    }
  }
  
  init(cpu:Int){
    self.cpu = cpu
  }
  
  convenience init(flag:Bool){
    self.init(cpu:flag ? 100:1)
  }
  
}

