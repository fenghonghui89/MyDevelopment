//
//  ViewController5.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_logic: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  //MARK: - <<< for循环 >>>
  //MARK:对区间操作符进行循环
  func func1_1() {
    
    for index in 1...5
    {
      print("index:\(index)");
    }
    
    for index in 1..<10
    {
      print("index1:\(index)");
    }
    
    let base = 3;
    let power = 3;
    var answer = 1;
    for _ in 1...power
    {
      answer *= base;
    }
    print("\(answer)");
    
  }
  
  //MARK:枚举数组和字典中的元素
  func func1_2() {
    
    let arr = ["one","two",12];
    for value in arr
    {
      print("\(value)");
    }
    
    
    let dic = ["k1":"v1",1:3];
    for (k,v) in dic
    {
      print("k:\(k),v:\(v)");
    }

  }
  
  //MARK:枚举字符串中的所有字符
  func func1_3() {
    
    for character in "Hello World".characters
    {
      print("<\(character)>");
    }

  }
  
  //MARK:条件增量for循环(循环标识如果在for外部定义则for内部不用加var)
  func func1_4() {
    
    for i in 0 ..< 3
    {
      print("i:\(i)");
    }
    
    var ii = 0;
    for ii = 0;ii<3;ii += 1
    {
      print("ii:\(ii)");
    }

  }
  
  
  //MARK: - <<< while循环 >>>
  
  func func2_1() {
    
    var i = 0;
    while i<3  {
      print("\(i)");
      i += 1;
    }

  }
  
  //MARK: - <<< repeat while循环（即do while） >>>
  func func3_1() {
    
    var i = 0;
    
    repeat{
      print("\(i)");
      i += 1;
    }while i<3;

  }
  
  //MARK: - <<< switch >>>
  //MARK:可以不写break，多情况匹配跟c/oc不一样，创建变量不用加大括号
  func func4_1() {
    
    let c:Character = "c";
    switch c {
    case "a","b","c","d":
      print("is c : \(c)");
    case "e","f":
      print("no c : \(c)");
    default:
      print("no char");
    }
    
    
    let cc:String = "cc";
    switch cc {
    case "a": break
    case "cc":
      let i = 3;
      print("\(i)");
    default:break;
      
    }
    
  }
  
  //MARK:范围匹配
  func func4_2() {
    
    let i = 300_00_00;
    
    switch i {
    case 1...100_00_00:
      break;
    case 100_00_01...299_99_99:
      print("100_00_01...299_99_99");
    case 300_00_00...4000000:
      print("yes");
    default:
      break;
    }
    
  }
  
  //MARK:元组匹配 值绑定 下划线匹配任何值
  func func4_3() {
    
    let somePoint = (0,3);
    
    switch somePoint {
    case (0, 0):
      print("(0, 0) is at the origin")
    case (let x, 0)://值绑定
      print("(\(x), 0) is on the x-axis")
    case (0, _)://下划线匹配任何值
      print("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2):
      print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    case let(x,y)://匹配元组
      print("somewhere:(\(x),\(y))");
    default:
      print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
    }
  }
  
  //MARK:where条件匹配
  func func4_4() {
    
    let p = (3,3);
    
    switch p {
    case let(x,y) where x == y:
      print("x = y");
    default:
      print("no match");
    }
    
  }
  
  //MARK:fallthrough关键字直接掉入下一个case
  func func4_5() {
    
    let number = 5;
    var str = "the number \(number) is ";
    
    switch number {
    case 1...5:
      str += "a prime number ";
      fallthrough;
    default:
      str += "but also is int";
    }
    
    print(str);
    
    
  }
  
  //MARK:嵌套循环下用标签
  func func4_6() {
    
    let finalSquare = 25//胜利条件
    
    //棋盘格子对应的数值 默认是0 特殊格子有加有减
    var board = [Int](count: finalSquare + 1, repeatedValue: 0)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    
    var square = 0;//当前走到的哪个格子
    var diceRoll = 0;//骰子掷出的数子
    
    
    gameLoop:
      while square != finalSquare {
        
        diceRoll += 1;
        if diceRoll == 7 {
          diceRoll = 1
        }
        
        switch square + diceRoll {
        case finalSquare://如果当前步数=胜利条件，则跳出循环
          print("break");
          break gameLoop;
        case let newSquare where newSquare > finalSquare://如果当前步数>胜利条件，则不走，继续下一轮
          print("continue");
          continue gameLoop;
        default:
          square += diceRoll//加上骰子的数字
          square += board[square]//加上格子的数值
          print(square);
        }
        
    }
    
    print("Game over!")

  }
  
}
