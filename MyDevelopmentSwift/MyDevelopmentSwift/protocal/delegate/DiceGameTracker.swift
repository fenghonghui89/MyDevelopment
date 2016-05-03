//
//  DiceGameTracker.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

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
