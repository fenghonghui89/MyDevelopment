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
    
    func9();
  }
  
  //MARK:- <<< method >>>
  //MARK:协议属性 协议方法 mutating方法修改实例的属性
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
  
  //MARK:使用空扩展使一个符合要求的类采用协议
  func func4(){
    
    let simon = Hamster(name: "Simon")
    let somethingTextRepresentable:TextRepresentable = simon
    print(somethingTextRepresentable.asText())// prints "A hamster named Simon"

  }
  
  
  //MARK:协议集合类型
  func func5(){
    
    let game = SnakesAndLadders();
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    let hamster = Hamster(name: "Simon")
    
    let things:[TextRepresentable] = [game,dice,hamster];//协议集合类型
    
    for thing in things {
      print(thing.asText());
    }
    
    // A game of Snakes and Ladders with 25 squares
    // A 12-sided dice
    // A hamster named Simon
  }
  
  //MARK:协议继承
  func func6() {
    
    let game = SnakesAndLadders();
    print(game.asPrettyText());
  }
  
  //MARK:协议组合 类似于oc的id<delegate1,delegate2...>
  func func7(){
    
    let p1 = Person1(name: "Hany", age: "27")
    let p2 = Person1(name: "HHH", age: "28")
    
    p1.wishHappyBirthday(p2)
  }
  
  //MARK:is as 检查是否遵守协议
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
  
  
  
  //MARK:@objc optional
  func func9(){
    
    let student:OCProtocol = Studnet(name: "Hany")
    
    let occlass = OCClass(student: student);
    print("name:\(occlass.student.name!)")
  
  }
}







