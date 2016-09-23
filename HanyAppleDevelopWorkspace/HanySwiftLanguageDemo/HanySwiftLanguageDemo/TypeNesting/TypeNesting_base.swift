//
//  TypeNesting_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//类型嵌套

import Foundation

func root_TypeNesting_base() {
  
  
}

//MARK:类型嵌套
private func func_ReferringToNestedTypes() {
  
  let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
  print("theAceOfSpades: \(theAceOfSpades.description)")// 打印出 "theAceOfSpades: suit is ♠, value is 1 or 11"
  
  let heartsSymbol = BlackjackCard.Suit.hearts.rawValue// 红心的符号 为 "♡"
  print(heartsSymbol);
}


//MARK:- <<< class >>>

//MARK:类型嵌套
private struct BlackjackCard {
  
  // 嵌套定义枚举型Suit
  enum Suit: Character {
    case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
  }
  
  // 嵌套定义枚举型Rank
  enum Rank: Int {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
    struct Values {
      let first: Int,second: Int?
    }
    var values: Values {
      switch self {
      case .ace:
        return Values(first: 1, second: 11)
      case .jack, .queen, .king:
        return Values(first: 10, second: nil)
      default:
        return Values(first: self.rawValue, second: nil)
      }
    }
  }
  
  // BlackjackCard 的属性和方法
  let rank: Rank, suit: Suit
  var description: String {
    var output = "suit is \(suit.rawValue),"
    output += " value is \(rank.values.first)"
    if let second = rank.values.second {
      output += " or \(second)"
    }
    return output
  }
}
