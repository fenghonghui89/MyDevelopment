//
//  SnakesAndLadders.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

//MARK:- 委托
protocol DiceGame {
  
  var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate {
  
  func gameDidStart(game: protocol<DiceGame> )//protocal<协议1,协议2...>
  func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)//单协议可以直接 :协议名
  func gameDidEnd(game: DiceGame)
}



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

class DiceGameTracker: DiceGameDelegate {
  
  var numberOfTurns = 0
  
  
  //DiceGameDelegate method
  func gameDidStart(game: DiceGame) {
    numberOfTurns = 0
    if game is SnakesAndLadders {
      print("Started a new game of Snakes and Ladders")
    }
    print("The game is using a \(game.dice.sides)-sided dice")
  }
  
  func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
    numberOfTurns = numberOfTurns+1
    print("Rolled a \(diceRoll)")
  }
  
  func gameDidEnd(game: DiceGame) {
    print("The game lasted for \(numberOfTurns) turns")
  }
}

//MARK:- 用扩展给类添加协议实现
extension SnakesAndLadders:TextRepresentable {
  
  var textualDescription: String {
    return "A game of Snakes and Ladders with \(finalSquare) squares"
  }
}

//MARK:- 协议继承协议
protocol PrettyTextRepresentable: TextRepresentable {
  var prettyTextualDescription: String { get }
}

extension SnakesAndLadders:PrettyTextRepresentable{
  
  var prettyTextualDescription: String {
    var output = textualDescription + ":\n"
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


