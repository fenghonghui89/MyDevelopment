//
//  ClassOnlyProtocols.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/16.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

protocol ClassOnlyProtocol_SuperProtocol {
  
}

protocol SomeClassOnlyProtocol: class, ClassOnlyProtocol_SuperProtocol {
  // class-only protocol definition goes here
}

