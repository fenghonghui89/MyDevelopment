//
//  ViewController6.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController6: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    //    //TODO:--- for循环 ---
    //    //TODO:对区间操作符进行循环
    //    for index in 1...5
    //    {
    //      print("index:\(index)");
    //    }
    //
    //    for index in 1..<10
    //    {
    //      print("index1:\(index)");
    //    }
    //
    //    let base = 3;
    //    let power = 3;
    //    var answer = 1;
    //    for _ in 1...power
    //    {
    //      answer *= base;
    //    }
    //    print("\(answer)");
    //
    //    //TODO:枚举数组和字典中的元素
    //    let arr = ["one","two",12];
    //    for value in arr
    //    {
    //      print("\(value)");
    //    }
    //
    //
    //    let dic = ["k1":"v1",1:3];
    //    for (k,v) in dic
    //    {
    //      print("k:\(k),v:\(v)");
    //    }
    //
    //
    //    //TODO:枚举字符串中的所有字符
    //    for character in "Hello World".characters
    //    {
    //      print("<\(character)>");
    //    }
    //
    //    //TODO:条件增量for循环(循环标识如果在for外部定义则for内部不用加var)
    //    for i in 0 ..< 3
    //    {
    //      print("i:\(i)");
    //    }
    //
    //    var ii = 0;
    //    for ii = 0;ii<3;ii += 1
    //    {
    //      print("ii:\(ii)");
    //    }
    
    
    
    
    //    //TODO:--- while循环 ---
    //    var i = 0;
    //    while i<3  {
    //      print("\(i)");
    //      i += 1;
    //    }
    
    
    
    //    //TODO:--- repeat while循环（即do while） ---
    //    var i = 0;
    //
    //    repeat{
    //      print("\(i)");
    //      i += 1;
    //    }while i<3;
    
    
    
    
    //
    //    //TODO:--- switch ---
    //    //TODO:可以不写break，多情况匹配跟c/oc不一样，创建变量不用加大括号
    //    let c:Character = "c";
    //    switch c {
    //    case "a","b","c","d":
    //      print("is c : \(c)");
    //    case "e","f":
    //      print("no c : \(c)");
    //    default:
    //      print("no char");
    //    }
    //
    //
    //    let cc:String = "cc";
    //    switch cc {
    //    case "a": break
    //    case "cc":
    //      let i = 3;
    //      print("\(i)");
    //    default:break;
    //
    //    }
    //
    //
    //    //TODO:范围匹配
    //    let i = 300_00_00;
    //
    //    switch i {
    //    case 1...100_00_00:
    //      break;
    //    case 100_00_01...299_99_99:
    //      print("100_00_01...299_99_99");
    //    case 300_00_00...4000000:
    //      print("yes");
    //    default:
    //      break;
    //    }
    //
    //
    //    //TODO:元组匹配 值绑定 下划线匹配任何值
    //    let somePoint = (0,3);
    //
    //    switch somePoint {
    //    case (0, 0):
    //      print("(0, 0) is at the origin")
    //    case (let x, 0)://值绑定
    //      print("(\(x), 0) is on the x-axis")
    //    case (0, _)://下划线匹配任何值
    //      print("(0, \(somePoint.1)) is on the y-axis")
    //    case (-2...2, -2...2):
    //      print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    //    case let(x,y)://匹配元组
    //      print("somewhere:(\(x),\(y))");
    //    default:
    //      print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
    //    }
    //
    //
    //    //TODO:where条件匹配
    //    let p = (3,3);
    //    switch p {
    //    case let(x,y) where x == y:
    //      print("x = y");
    //    default:
    //      print("no match");
    //    }
    //
    //
    //    //TODO:fallthrough关键字直接掉入下一个case
    //    let number = 5;
    //    var str = "the number \(number) is ";
    //
    //    switch number {
    //    case 1...5:
    //      str += "a prime number ";
    //      fallthrough;
    //    default:
    //      str += "but also is int";
    //    }
    //
    //    print(str);
    
    
    
    
    
    //TODO:嵌套循环下用标签
    let finalSquare = 25
    var board = [Int](count: finalSquare + 1, repeatedValue: 0)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    var square = 0;
    var diceRoll = 0;
    
    
    gameLoop:
      while square != finalSquare {
        
        diceRoll += 1;
        if diceRoll == 7 {
          diceRoll = 1
        }
        
        switch square + diceRoll {
        case finalSquare:
          print("break");
          break gameLoop;
        case let newSquare where newSquare > finalSquare:
          print("continue");
          continue gameLoop;
        default:
          square += diceRoll
          square += board[square]
          print(square);
        }
        
    }
    print("Game over!")
    
    
    
    
    
    
    
    
  }
}
