//
//  ErrorHanding_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//异常捕获

import Foundation

func root_ErrorHanding_base() {
  
}
//MARK:- 例子 throws关键字接参数后面
private func func_Propagating_Errors_Using_Throwing_Functions(){
  
  let vendingMachine = VendingMachine()
  vendingMachine.coinsDeposited = 8
  
  do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
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

private func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
  
  let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
    ]
  
  let snackName = favoriteSnacks[person] ?? "Candy Bar"
  
  try vendingMachine.vend(itemNamed: snackName)
  
}

//MARK:- try?返回nil 方便一次性处理所有异常（出错依然进入do？）/ try!忽略所有错误，很可能有运行时错误
private func func_Converting_Errors_to_Optional_Values(){
  
  let data:String?
  
  do{
    data = try fetchData()
    print("get data:\(data)")//出错依然进入这里？？
  }catch{
    data = nil
    print("error...")
  }
  
}

private func fetchData()throws -> String? {
  
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

private enum FetchDataError:ErrorType {
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

private func fetchDataFromDisk()throws -> String{
  defer{
    print("clean disk");
  }
  
  guard arc4random()%10>5 else {
    throw FetchDataError.diskError;
  }
  
  return "disk data"
}

private func fetchDataFromServer()throws -> String{
  
  defer{
    print("server disk");
  }
  
  guard arc4random()%10>5 else{
    throw FetchDataError.serverError;
  }
  
  return "server data"
}



//MARK:- 在你的代码块就要结束前 如果你使用了 defer 在其之中的代码就会运行
private func func_Specifying_Cleanup_Actions() {
  
  if let result = doSomething() {
    print("get data:\(result)");
  }else{
    print("is nil..");
  }
}

private func doSomething()->String?{
  
  defer{
    print("clean up");
  }
  
  if arc4random()%10>1 {
    return "大于"
  }else{
    return nil;
  }
}

//MARK:- fatalError 无条件打印日志并终止执行
private func func_fatalError() {
  fatalError("init(coder:) has not been implemented")
}
