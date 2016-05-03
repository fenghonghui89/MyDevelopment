//
//  SnakesAndLadders.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation


class SnakesAndLadders: DiceGame {//遵守DiceGame协议
  
  let finalSquare = 25
  var square = 0
  var board: [Int]
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())//骰子，DiceGame协议要求
  
  init() {
    board = [Int](count: finalSquare + 1, repeatedValue: 0)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
  }
  
  var delegate: DiceGameDelegate?//delegate
  
  func play() {//DiceGame协议要求
    
    //游戏开始
    square = 0
    delegate?.gameDidStart(self)
    
    //游戏开始新一轮
    gameLoop: while square != finalSquare {
      
      let diceRoll = dice.roll()
      delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
      
      switch square + diceRoll {
      case finalSquare:
        break gameLoop
      case let newSquare where newSquare > finalSquare:
        continue gameLoop
      default:
        square += diceRoll
        square += board[square]
      }
    }
    
    //游戏结束
    delegate?.gameDidEnd(self)
  }
}

//协议继承
extension SnakesAndLadders:PrettyTextRepresentable{
  
  //PrettyTextRepresentable delegate method
  func asText() -> String {
    return "A game of Snakes and Ladders with \(finalSquare) squares"
  }

  
  func asPrettyText() -> String {
    
    var output = asText() + ":\n"
    
    for index in 1...finalSquare {
      
      switch board[index] {
      case let ladder where ladder > 0:
        output += "▲ "
      case let snake where snake < 0:
        output += "▼ "
      default:
        output += "○ "
      }
    }
    return output
  }
  
}


