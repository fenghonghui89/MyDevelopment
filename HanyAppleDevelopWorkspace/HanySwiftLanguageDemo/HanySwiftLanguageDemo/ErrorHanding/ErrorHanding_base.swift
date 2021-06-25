//
//  ErrorHanding_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//异常捕获
//do catch try throws throw defer guard
//func fetchDataFromServer()throws -> String
//try? - 方便处理所有异常  try! - ???
//try? or try! 不需要do catch

import Foundation

func root_ErrorHanding_base() {
    _ = try! requestData()
    
//    requestData1()
}

//MARK:- 例子 throws / throw / do catch / try?tyr!
/*
 
 方法调用栈:
 vc层: do try? 或者 do try!
    ↓
 func requestData()throws{}
    ↓
 func managerLayr()throws->String?
    ↓
 func netLayer()throws->String?
 
 try?返回nil 方便一次性处理所有异常（出错依然进入do？）
 try!忽略所有错误，如果下层抛出错误，会崩(运行时错误)
 
 调用"throws或者throws->xxx结尾"的方法，要用try调用，所以要用do catch包住 或者 _ = tyr func()
 */
enum BJErrorType:Error {
    
    case errorNet0
    case errorNet1
    case error1
    case error2(code: Int)
    
    var description:String?{
      switch self {
      case .errorNet0:
        return "网络错误0"
      case .errorNet1:
        return "网络错误1"
      case .error1:
        return "接口错误";
      case .error2:
        return "业务错误";
      }
    }
}

func netLayer() throws -> String? {
    
    let data = arc4random()%10
    
    if data == 2 {
        print("netLayer 网络错误0..")
        throw BJErrorType.errorNet0
    }
    
    if data == 3 {
        print("netLayer 网络错误1..")
        throw BJErrorType.errorNet1
    }
    
    if data == 4 {
        print("netLayer 接口错误..")
        throw BJErrorType.error1
    }
    
    if data == 5 {
        print("netLayer 业务错误..")
        throw BJErrorType.error2(code: 2)
    }
    
    print("netLayer success..")
    
//    return "data"
    return nil
}

func managerLayer() throws -> String? {
    
    do {
        let data:String? = try netLayer()
        print("managerLayer..\(data ?? "空数据")")
        return data
    } catch BJErrorType.error1 {
        print("managerLayer..接口错误")
        throw BJErrorType.error1
    } catch BJErrorType.error2(let code){
        print("managerLayer..业务错误:\(code)")
        throw BJErrorType.error2(code: code)
    } catch let err as BJErrorType {
        print("managerLayer..网络错误:\(err) - \(err.description ?? "未知网络错误")")
        throw err
    }
}

func requestData() throws{
    
    do {
        let data:String? = try managerLayer()
        print("vc层..\(data ?? "空数据")")
    } catch let err as BJErrorType {
        print("vc层..\(err)")
    }
    
}

func requestData1() {
    
    //如果下层抛出错误 会崩
//    let data:String? = try! managerLayer()
//    print("get 业务层 data..\(data ?? "空数据")")
    
    //如果下层抛出错误 不会崩 为nil
    let data:String? = try? managerLayer()
    print("get 业务层 data..\(data ?? "空数据")")
    
    
}

//MARK:- 例子 throws关键字接参数后面
private func func_Propagating_Errors_Using_Throwing_Functions(){
  
  let vendingMachine = VendingMachine()
  vendingMachine.coinsDeposited = 8//投入硬币
  
  //调用"throws或者throws->xxx结尾"的方法，要用try调用，所以要用do catch包住 或者 _ = tyr func()
  do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
  } catch VendingMachineError.invalidSelection {
    print("error:\(VendingMachineError.invalidSelection.description)")
  } catch VendingMachineError.outOfStock {
    print("error:\(VendingMachineError.outOfStock.description)")
  } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("error:\(VendingMachineError.insufficientFunds(coinsNeeded: coinsNeeded).description)")
  } catch {
    print("error:unknow error")
  }
  // Prints "Insufficient funds. Please insert an additional 2 coins."
  
  
}

private func buyFavoriteSnack(_ person: String, vendingMachine: VendingMachine) throws{
  
  let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
    ]
  
  let snackName = favoriteSnacks[person] ?? "Candy Bar"
  
  try vendingMachine.vend(itemNamed: snackName)
  
}

//MARK:- try?返回nil 方便一次性处理所有异常/ try!忽略所有错误，很可能有运行时错误
private func func_Converting_Errors_to_Optional_Values(){
  
  let data:String?
  
  do{
    data = try fetchData()
    print("get data:\(data ?? "空数据不属于出错")")
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

private enum FetchDataError:Error {
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
    print("clean server disk");
  }
  
  guard arc4random()%10>5 else{
    throw FetchDataError.serverError;
  }
  
  return "server data"
}



//MARK:- 在你的代码块就要结束前 如果你使用了 defer 在其之中的代码就会运行
/*
 defer 会在当前作用域(并不仅限于函数)结束时执行。
 defer 执行的顺序为逆序(栈式，先进后出)。
 defer 中捕获的变量的值是可以进行变更的。
 用一句话概括，就是 defer block 里的代码会在函数 return 之前执行，无论函数是从哪个分支 return 的，还是有 throw，还是自然而然走到最后一行。
 场景：清理工作、回收资源、调 completion block、调 super 方法
 */
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

private func foo() {
    defer {
      print("finally")
    }
    do {
      throw NSError()
      print("impossible")
    } catch {
      print("handle error")
    }
    
    /*
     handle error
     finally
     */
    
    
    do {
      defer {
        print("finally")
      }
      throw NSError()
      print("impossible")
    } catch {
      print("handle error")
    }
    
    /*
     finally
     handle error
     */

}

//MARK:- fatalError 无条件打印日志并终止执行
private func func_fatalError() {
  fatalError("init(coder:) has not been implemented")
}


//MARK:- 例子 error.code 不能用泛型因为泛型不支持非对象类型
enum TestEnum:Int {
    case first = 0,
    second = 1,
    third = 2,
    defaultTest = 3
}

func test() {
    
    var errorResult:NSError?
    let error:NSError = NSError.init(domain: NSURLErrorDomain, code: 4, userInfo: nil)
    errorResult = error
    
    var result:TestEnum?
    result = (errorResult?.code).map { TestEnum(rawValue: $0) }!
    
    print(".....\(result ?? TestEnum.defaultTest)");
    
    if let result = result  {
        print("\(result)")
    }else{
        print("\(error.code)")
    }
}


