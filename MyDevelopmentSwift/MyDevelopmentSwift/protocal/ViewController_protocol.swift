//
//  ViewController_protocal.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/4/29.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_protocol:UIViewController{
  
  override func viewDidLoad() {
    
    super.viewDidLoad();
    
    func8();
  }
  
  //MARK:- <<< method >>>
  //MARK:属性要求 方法要求 mutating方法要求
  func func1(){
    
    let ncc1771 = Starship(name: "Enterprise", prefix: "USS")
    print(ncc1771.fullName);
    
    ncc1771.getset = "abc"
    print(ncc1771.getset)
    
    ncc1771.toggle();
    print(ncc1771.state);
  }
  
  //MARK:协议类型 给类扩展协议
  func func2(){
    
    let generator = LinearCongruentialGenerator()
    print("Here's a random number: \(generator.random())")// prints "Here's a random number: 0.37464991998171"
    print("And another one: \(generator.random())")// prints "And another one: 0.729023776863283"
    
    let d6 = Dice(sides: 6, generator: generator);
    print("\(d6.asText())")//扩展的协议方法
    
    for _ in 1...5 {
      print("Random dice roll is \(d6.roll())")
    }
  }
  
  //MARK:委托
  func func3(){
    
    let tracker = DiceGameTracker()
    
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
    print("\(game.asText())")
    
    // Started a new game of Snakes and Ladders
    // The game is using a 6-sided dice
    // Rolled a 3
    // Rolled a 5
    // Rolled a 4
    // Rolled a 5
    // The game lasted for 4 turns

  }
  
  //MARK:采用扩展声明协议
  func func4(){
    
    let simonTheHamster = Hamster(name: "Simon")
    
    let somethingTextRepresentable:TextRepresentable = simonTheHamster
    print(somethingTextRepresentable.asText())// prints "A hamster named Simon"

  }
  
  
  //MARK:协议集合类型
  func func5(){
    
    let game = SnakesAndLadders();
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    let hamster = Hamster(name: "Simon")
    
    let things:[TextRepresentable] = [game,dice,hamster];
    
    for thing in things {
      print(thing.asText());
    }
  }
  
  //MARK:协议继承
  func func6() {
    
    let game = SnakesAndLadders();
    print(game.asPrettyText());
  }
  
  //MARK:协议组合
  func func7(){
    
    let p1 = Person1(name: "Hany", age: "27")
    let p2 = Person2(name: "HHH", age: "28")
    p1.wishHappyBirthday(p2)
  }
  
  //MARK:检查是否遵守协议
  func func8(){
    
    let p1 = Person1(name: "Hany", age: "27")
    let game = SnakesAndLadders()
    let hamster = Hamster(name: "Simon")
    
    let objects:[AnyObject] = [p1,game,hamster];
    
    for object in objects {
      if let objectWithNamed = object as? Named {
        print("is this protocol:\(objectWithNamed.name)");
      }else{
        print("is not this protocol");
      }
    }
    
  }
}







