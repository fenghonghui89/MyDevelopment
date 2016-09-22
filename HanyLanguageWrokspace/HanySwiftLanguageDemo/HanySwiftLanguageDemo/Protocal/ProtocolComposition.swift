//
//  Person1.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
/*
 协议组合 类似于oc的id<delegate1,delegate2...>
*/


import Foundation

protocol Named {
  var name: String { get }
}
protocol Aged {
  var age: Int { get }
}

struct Person_ProtocolComposition: Named, Aged {
  var name: String
  var age: Int
}

