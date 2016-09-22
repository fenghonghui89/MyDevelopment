//
//  File.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 MD. All rights reserved.
//
/*
 1.代码书写如下，注意@IBDesignable @IBInspectable
 2.xib class改成自定义view的 第三个标识检查器的 User Define Runtime Attributes就会出现设置的属性
 3.xib 第四个属性检查器就可以看到设置的属性项目并且可以修改
*/
import Foundation
import UIKit

@IBDesignable
class CustomView:UIView {
  
  @IBInspectable var cornerRadius: CGFloat = 0.0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = true
    }
  }
  
  @IBInspectable var bColor: UIColor = UIColor() {
    didSet {
      layer.borderColor = bColor.cgColor
    }
  }
  
  @IBInspectable var bWidth: CGFloat = 0.0 {
    didSet {
      layer.borderWidth = bWidth
    }
  }
  
}
