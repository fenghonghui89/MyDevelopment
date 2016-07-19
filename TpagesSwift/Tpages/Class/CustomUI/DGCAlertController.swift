//
//  DGCAlertController.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/13.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

enum DGCAlertType:Int {
  case DGCAlertTypeJustConfirm = 1,
  DGCAlertTypeNoAction = 2,
  DGCAlertTypeTwoSelect = 3
}

class DGCAlertController: UIAlertController {
  
  
  static func alertControlller(title:String?,message:String?,type:DGCAlertType,block:((run:Bool)->Void)?)->DGCAlertController{
  
    let ac = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    switch type {
      
    case .DGCAlertTypeTwoSelect:
      let action:UIAlertAction = UIAlertAction(title: "取消", style:.Default, handler:{
        (action:UIAlertAction)->Void in
        ac.dismissViewControllerAnimated(true, completion: nil)
      })
      
      let action1:UIAlertAction = UIAlertAction(title: "打开", style:.Default, handler:{
        (action1:UIAlertAction)->Void in
        block!(run: true)
      })
      
      ac.addAction(action)
      ac.addAction(action1)
      
    case .DGCAlertTypeJustConfirm:
      let action:UIAlertAction = UIAlertAction(title: "确定", style:.Default, handler:nil)
      ac.addAction(action)
    default: break
      
    }
    
    return ac as! DGCAlertController

  }
  
}