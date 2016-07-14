//
//  ViewController_FreeTest1.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/7/14.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

class ViewController_FreeTest1: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let basePC = BasePC(level: 10)
    print(basePC.level)
    
    
  }
}


class Mac: BasePC {
  
  var model_name:String?
  
  
  

}