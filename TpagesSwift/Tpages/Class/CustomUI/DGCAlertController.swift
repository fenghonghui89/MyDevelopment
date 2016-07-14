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
  

//  +(DGCAlertController *)alertControllerWithTitle:(NSString * __nullable)title
//  message:(NSString * __nullable)message
//  type:(DGCAlertType)type
//  block:(void(^ __nullable)(bool run))block;
//  {
//  DGCAlertController *vc = [super alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//  
//  __block DGCAlertController *ac = vc;
//  
//  switch (type) {
//  case DGCAlertTypeTwoSelect:
//  {
//  [vc addActionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//  [ac dismissViewControllerAnimated:YES completion:nil];
//  }];
//  [vc addActionWithTitle:NSLocalizedString(@"打开", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//  block(YES);
//  }];
//  }
//  break;
//  case DGCAlertTypeJustConfirm:
//  {
//  [vc addActionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:nil];
//  }
//  break;
//  case DGCAlertTypeNoAction:
//  break;
//  default:
//  break;
//  }
//  
//  return vc;
//  }
  
  init(title:String,message:String,type:DGCAlertType,block:(run:Bool)->Void){
    
    super.init(nibName: nil, bundle: nil)

    switch type {
    case .DGCAlertTypeTwoSelect:
      self.addActionWithTitle("取消", style: .Default, handle: { (action) in
        self.dismissViewControllerAnimated(true, completion: nil)
      })
      self.addActionWithTitle("打开", style: .Default, handle: { (action) in
        block(run: true)
      })
    case .DGCAlertTypeJustConfirm:
      self.addActionWithTitle("确定", style: .Default, handle: { (action) in
        
      })
    default: break
      
    }

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addActionWithTitle(title:String,style:UIAlertActionStyle,handle:(action:UIAlertAction)->Void) {
    
    let action:UIAlertAction = UIAlertAction(title: title, style: style, handler: handle)
    self.addAction(action)
    
  }
}