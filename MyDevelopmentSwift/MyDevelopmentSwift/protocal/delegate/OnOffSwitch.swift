//
//  OnOffSwitch.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/16.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation



protocol Togglable {
  mutating func toggle()
}

enum OnOffSwitch: Togglable {
  case Off, On
  mutating func toggle() {
    switch self {
    case Off:
      self = On
    case On:
      self = Off
    }
  }
}