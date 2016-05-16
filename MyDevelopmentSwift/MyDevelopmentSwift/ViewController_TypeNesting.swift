//
//  ViewController_TypeNseting.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/16.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_TypeNesting: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    func4();
  }
  
  
  //MARK:类型嵌套
  func func4() {
    
    let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
    print("theAceOfSpades: \(theAceOfSpades.description)")// 打印出 "theAceOfSpades: suit is ♠, value is 1 or 11"
    
    let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue// 红心的符号 为 "♡"
    print(heartsSymbol);
  }
}




//MARK:- <<< class >>>

//MARK:类型嵌套
struct BlackjackCard {
  
  // 嵌套定义枚举型Suit
  enum Suit: Character {
    case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
  }
  
  // 嵌套定义枚举型Rank
  enum Rank: Int {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King, Ace
    struct Values {
      let first: Int,second: Int?
    }
    var values: Values {
      switch self {
      case .Ace:
        return Values(first: 1, second: 11)
      case .Jack, .Queen, .King:
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