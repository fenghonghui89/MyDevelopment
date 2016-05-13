//
//  ViewController_ErrorHandling.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/13.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit







class ViewController_ErrorHandling: UIViewController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad();
    
    func_Specifying_Cleanup_Actions();
  }
  
  
  //MARK:- base
  func func_Propagating_Errors_Using_Throwing_Functions(){
    
    let vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8
    
    do {
      try self.buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
    } catch VendingMachineError.InvalidSelection {
      print("error:\(VendingMachineError.InvalidSelection.description)")
    } catch VendingMachineError.OutOfStock {
      print("error:\(VendingMachineError.OutOfStock.description)")
    } catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
      print("error:\(VendingMachineError.InsufficientFunds(coinsNeeded: coinsNeeded).description)")
    } catch {
      print("error:unknow error")
    }
    // Prints "Insufficient funds. Please insert an additional 2 coins."
    

  }
  
  func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    
    let favoriteSnacks = [
      "Alice": "Chips",
      "Bob": "Licorice",
      "Eve": "Pretzels",
      ]
    
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    
    try vendingMachine.vend(itemNamed: snackName)
    
  }
  
  //MARK:- try?返回nil 方便一次性处理所有异常（暂时出错依然进入do）/ try!忽略所有错误，很可能有运行时错误
  func func_Converting_Errors_to_Optional_Values(){
    
    let data:String?
    
    do{
      data = try fetchData()
      print("get data:\(data)")//出错依然进入这里？？
    }catch{
      data = nil
      print("error...")
    }
    
  }
  
  func fetchData()throws -> String? {
    
    if let data = try? fetchDataFromDisk() {
      print("receive disk data")
      return data
    }
    
    if let data = try? fetchDataFromServer() {
      print("receive server data")
      return data
    }
    
    return nil
  }
  
  enum FetchDataError:ErrorType {
    case diskError
    case serverError
    
    var description:String?{
      switch self {
      case .diskError:
        return "diskError";
      case .serverError:
        return "serverError";
      }
    }
    
  }
  
  func fetchDataFromDisk()throws -> String{
    defer{
      print("clean disk");
    }
    
    guard arc4random()%10>5 else {
      throw FetchDataError.diskError;
    }
    
    return "disk data"
  }
  
  func fetchDataFromServer()throws -> String{
    
    defer{
      print("server disk");
    }
    
    guard arc4random()%10>5 else{
      throw FetchDataError.serverError;
    }
    
    return "server data"
  }
  
  
  
  //MARK:- 在你的代码块就要结束前 如果你使用了 defer 在其之中的代码就会运行
  func func_Specifying_Cleanup_Actions() {
    
    if let result = doSomething() {
      print("get data:\(result)");
    }else{
      print("is nil..");
    }
  }
  
  func doSomething()->String?{
    defer{
      print("clean up");
    }
    
    if arc4random()%10>1 {
      return "大于"
    }else{
      return nil;
    }
  }
}




