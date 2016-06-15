//
//  ViewController_SwiftAndOC.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation
import UIKit
class ViewController_SwiftAndOC:UIViewController {
  
  override func viewDidLoad() {
    
    func_swift();
  }
  
  /*
   swift调用oc，要在桥接文件里import oc的.h头文件
   配置在build setting - Objective-C BridgingHeader
   */
  func func_oc(){
    let objc:OC_Object = OC_Object()
    objc.sayHello()
    objc.translateToSwift();
  }
  
  func func_swift(){
    
    let vc:ViewController_Swift = ViewController_Swift(name: "Hany")!;
    vc.sayHello();
    
    let vc1:ViewController_Swift = ViewController_Swift();
    self.presentViewController(vc1, animated: true, completion: nil);
    vc1.sayHello();
    vc1.func_internal();
    vc1.func_public();
    vc1.name = "Salae";
    
  }
}