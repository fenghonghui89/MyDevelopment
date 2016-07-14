//
//  ViewController_FreeTest1.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/7/14.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

class ViewController_FreeTest1: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let basePC = BasePC(level: 10)
    print(basePC.level)
    
    
    let fileManager = NSFileManager.defaultManager()
    let URL = NSURL.fileURLWithPath("/path/to/file")
    do {
      try fileManager.removeItemAtURL(URL)
    } catch let error as NSError {
      print("Error: \(error.domain)")
    }
    
    do{
      let dic = try NSJSONSerialization.JSONObjectWithData(NSData(), options: NSJSONReadingOptions.AllowFragments)
    }catch let error as NSError{
    
    }
    
    
    let str = self.test(true) {
      
      (response:NSURLResponse, responseObject:AnyObject?, error:NSError?)->Void in
      
      if (error != nil){
        do{
          let dic = try NSJSONSerialization.JSONObjectWithData(NSData(), options: NSJSONReadingOptions.AllowFragments)
        }catch let error as NSError{
          print("")
        }
      }
      
      
    }
  }
  
  func test(flag:Bool,block:(response:NSURLResponse, responseObject:AnyObject?, error:NSError?)->Void) ->String {
    return ""
  }
}


class Mac: BasePC {
  
  var model_name:String?
  
  
  

}