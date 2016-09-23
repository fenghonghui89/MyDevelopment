//
//  VendingMachine.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/13.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//定义错误类型
enum VendingMachineError: Error {
  case invalidSelection
  case insufficientFunds(coinsNeeded: Int)
  case outOfStock
}

extension VendingMachineError{
  
  var description:String {
    switch self {
    case .invalidSelection:
      return "InvalidSelection";
    case .outOfStock:
      return "OutOfStock";
    case .insufficientFunds(coinsNeeded: _):
      return "InsufficientFunds";
    }
  }
  
}

struct Item {
  var price:Int
  var count:Int
}


class VendingMachine {
  
  //存货清单
  var inventory = [
    "Candy Bar":Item(price: 12, count: 7),
    "Chips":Item(price: 10, count: 4),
    "Pretzels":Item(price: 7, count: 11)
  ]
  
  //放入的硬币
  var coinsDeposited = 0
  
  //投放小吃
  func dispenseSnack(_ snack: String) {
    print("Dispensing \(snack)")
  }
  
  //出售处理 注意throws throw
  func vend(itemNamed name: String) throws {
    
    guard let item = inventory[name] else {
      throw VendingMachineError.invalidSelection
    }
    
    guard item.count > 0 else {
      throw VendingMachineError.outOfStock
    }
    
    guard item.price <= coinsDeposited else {
      throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }
    
    coinsDeposited -= item.price
    
    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem
    
    dispenseSnack(name)
  }
  
}
