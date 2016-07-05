//
//  Protocal_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

func root_Protocal_base() {
  
}

//MARK:- <<< method >>>
//MARK:- 协议属性
private func func_PropertyRequirements(){
  //协议属性 协议方法
  let ncc1771 = Starship(name: "Enterprise", prefix: "USS")
  print(ncc1771.fullName);
  
  ncc1771.getset = "abc"
  print(ncc1771.getset)
  
}

//MARK:- 协议方法
private func func_MethodRequirements(){
  
  let generator = LinearCongruentialGenerator()
  print("Here's a random number: \(generator.random())")// Prints "Here's a random number: 0.37464991998171"
  print("And another one: \(generator.random())")// Prints "And another one: 0.729023776863283"
  
}

//MARK:- mutating方法修改实例的属性
private func func_MutatingMethodRequirements(){
  
  var lightSwitch = OnOffSwitch.Off
  lightSwitch.toggle()
  // lightSwitch is now equal to .On
}

//MARK:- 通过协议强制子类重写init方法
private func func_InitializerRequirements(){
  //详见InitializerRequirements.swift
}

//MARK:- 协议类型 类似于oc的id<delegate1> 只能修饰变量
func func_ProtocolsAsTypes(){
  
  let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator());
  
  for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
  }
  
}

//MARK:- 委托
private func func_Delegation(){
  
  let tracker = DiceGameTracker()
  
  let game = SnakesAndLadders()
  game.delegate = tracker
  game.play()
  
  // Started a new game of Snakes and Ladders
  // The game is using a 6-sided dice
  // Rolled a 3
  // Rolled a 5
  // Rolled a 4
  // Rolled a 5
  // The game lasted for 4 turns
  
}

//MARK:- 用扩展给类添加协议实现
private func func_AddingProtocolConformanceWithAnExtension() {
  
  let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
  print(d12.textualDescription)// Prints "A 12-sided dice"
  
  let game = SnakesAndLadders()
  print(game.textualDescription)// Prints "A game of Snakes and Ladders with 25 squares"
  
  
}

//MARK:- 使用空扩展声明一个符合要求的类采用协议
private func func_DeclaringProtocolAdoptionWithAnExtension(){
  
  let simonTheHamster = Hamster(name: "Simon")
  let somethingTextRepresentable: TextRepresentable = simonTheHamster
  print(somethingTextRepresentable.textualDescription)
  // Prints "A hamster named Simon"
  
}


//MARK:- 协议集合类型
private func func_CollectionsOfProtocolTypes(){
  
  let game = SnakesAndLadders();
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
  let hamster = Hamster(name: "Simon")
  
  let things:[TextRepresentable] = [game,dice,hamster];//协议集合类型
  
  for thing in things {
    print(thing.textualDescription);
  }
  
  // A game of Snakes and Ladders with 25 squares
  // A 12-sided dice
  // A hamster named Simon
}

//MARK:- 协议继承协议(不能写实现部分)
private func func_ProtocolInheritance() {
  
  let game = SnakesAndLadders();
  print(game.prettyTextualDescription)
  // A game of Snakes and Ladders with 25 squares:
  // ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
  
}

//MARK:- Class-Only Protocols 只有类能采用的协议，枚举和结构体不能采用
private func func_ClassOnlyProtocols(){
  //详见ClassOnlyProtocols.swift
}

//MARK:- 协议组合 类似于oc的id<delegate1,delegate2...> 只能修饰变量
private func func_ProtocolComposition() {
  
  let birthdayPerson = Person_ProtocolComposition(name: "Malcolm", age: 21)
  wishHappyBirthday(birthdayPerson)//Prints "Happy birthday Malcolm - you're 21!"
}

private func wishHappyBirthday(celebrator: protocol<Named,Aged>) {//协议组合
  print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}


//MARK:- is as 检查是否遵守协议
private func func_CheckingForProtocolConformance(){
  
  let p1 = Person_ProtocolComposition(name: "Hany", age: 21)
  let game = SnakesAndLadders()
  let hamster = Hamster(name: "Simon")
  
  let objects:[Any] = [p1,game,hamster];
  
  for object in objects {
    if let objectWithNamed = object as? Named {
      print("is this protocol:\(objectWithNamed.name)");
    }else{
      print("is not this protocol");
    }
  }
  
}



//MARK:- optional 可选协议实现只能用在@objc开头的协议
private func func_OptionalProtocolRequirements(){
  
  func_OptionalProtocolRequirements_example2();
}

private func func_OptionalProtocolRequirements_example1() {
  
  let student:OCProtocol = Studnet(name: "Hany")
  
  let occlass = OCClass(student: student);
  print("name:\(occlass.student.name!)")
}

private func func_OptionalProtocolRequirements_example2() {
  
  let counter = Counter()
  counter.dataSource = ThreeSource()
  
  for _ in 1...4 {
    counter.increment()
    print(counter.count)
  }
  // 3
  // 6
  // 9
  // 12
  
  
  counter.count = -4
  counter.dataSource = TowardsZeroSource()
  for _ in 1...5 {
    counter.increment()
    print(counter.count)
  }
  // -3
  // -2
  // -1
  // 0
  // 0
  
}

//MARK:- 扩展协议
private func func_ProtocolExtensions(){
  
  let generator = LinearCongruentialGenerator()
  print("Here's a random number: \(generator.random())")// Prints "Here's a random number: 0.37464991998171"
  print("And here's a random Boolean: \(generator.randomBool())")// Prints "And here's a random Boolean: true"
}
