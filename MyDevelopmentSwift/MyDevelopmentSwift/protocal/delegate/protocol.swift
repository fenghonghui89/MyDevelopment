//
//  protocal.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

protocol Named {
  
  var name:String{get}
  
}

protocol Aged {
  
  var age:String{get}
  
}

protocol RandomNumberGenerator{
  func random() -> Double

}

protocol DiceGame {
  
  var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate {
  
  func gameDidStart(game: protocol<DiceGame> )//protocal<协议1,协议2...>
  func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)//单协议可以直接 :协议名
  func gameDidEnd(game: DiceGame)
}


protocol TextRepresentable {
  func asText() -> String
}

//协议继承
protocol PrettyTextRepresentable: TextRepresentable {
  func asPrettyText() -> String
}

