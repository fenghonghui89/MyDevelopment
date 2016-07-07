//
//  File.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/14.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation
import UIKit

class ViewController_InteractingWithCApis: UIViewController {
  
  
  override func viewDidLoad() {
    
    sizeofTest()
  
  }
  
  
  //MARK:Constant Pointers
  func pointTest0() {

//    var x: Float = 0.0
//    var p: UnsafePointer<Float> = nil
//    takesAPointer(nil)
//    takesAPointer(p)
//    takesAPointer(&x)
//    takesAPointer([1.0, 2.0, 3.0])

    
    //UnsafePointer<Type>
    var x: Float = 0.0, y: Int = 0
    var p: UnsafePointer<Float> = nil, q: UnsafePointer<Int> = nil
    takesAVoidPointer(nil)
    takesAVoidPointer(p)
    takesAVoidPointer(q)
    takesAVoidPointer(&x)
    takesAVoidPointer(&y)
    takesAVoidPointer([1.0, 2.0, 3.0] as [Float])
    let intArray = [1, 2, 3]
    takesAVoidPointer(intArray)
    

  }
  
  func takesAPointer(x: UnsafePointer<Float>) {
    // ...
  }
  
  func takesAVoidPointer(x: UnsafePointer<Void>)  {
    // ...
  }
  

  
  //MARK:Mutable Pointers
 
  func pointTest1() {
    
    var x: Float = 0.0, y: Int = 0
    var p: UnsafeMutablePointer<Float> = nil, q: UnsafeMutablePointer<Int> = nil
    var a: [Float] = [1.0, 2.0, 3.0], b: [Int] = [1, 2, 3]
    takesAMutableVoidPointer(nil)
    takesAMutableVoidPointer(p)
    takesAMutableVoidPointer(q)
    takesAMutableVoidPointer(&x)
    takesAMutableVoidPointer(&y)
    takesAMutableVoidPointer(&a)
    takesAMutableVoidPointer(&b)
    
  }
  
  
  func takesAMutableVoidPointer(x: UnsafeMutablePointer<Void>)  {
    // ...
  }
  

  //MARK:Autoreleasing Pointers
  func pointTest2() {
    
    var x: NSDate? = nil
    var p: AutoreleasingUnsafeMutablePointer<NSDate?> = nil
    takesAnAutoreleasingPointer(nil)
    takesAnAutoreleasingPointer(p)
    takesAnAutoreleasingPointer(&x)
    
  }
  
  
  func takesAnAutoreleasingPointer(x: AutoreleasingUnsafeMutablePointer<NSDate?>) {
    // ...
  }
  

  //MARK:Function Pointers
  func pointTest3() {
    
//    var callbacks = CFArrayCallBacks(
//      version: 0,
//      retain: nil,
//      release: nil,
//      copyDescription: customCopyDescription,
//      equal: { p1, p2 -> DarwinBoolean in
//        // return Bool value
//      }
//    )
//    
//    var mutableArray = CFArrayCreateMutable(nil, 0, &callbacks)
  }
  
  func customCopyDescription(p: UnsafePointer<Void>) -> Unmanaged<CFString>! {
    // return an Unmanaged<CFString>! value
    return nil;
  }
  
  
  //MARK:Data Type Size Calculation
  func sizeofTest() {
    
    //不包括跟内存校准有关的填充物
    print(sizeof(timeval))
    print(sizeofValue(timeval))
    
    //跟c的sizeof 一致
    print(strideof(timeval))
    print(strideofValue(timeval))
    
    //例子
    let sockfd = socket(AF_INET, SOCK_STREAM, 0)
    var optval = timeval(tv_sec: 30, tv_usec: 0)
    let optlen = socklen_t(strideof(timeval))
    if setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &optval, optlen) == 0 {
      // ...
    }
    

  }
  
  
  //MARK:Variadic Functions
  func kl_VariadicFunctions() {
    
    print(sprintf("√2 ≅ %g", sqrt(2.0))!)
    // Prints "√2 ≅ 1.41421"
  }
  
  func sprintf(format: String, _ args: CVarArgType...) -> String? {
    return withVaList(args) { va_list in
      var buffer: UnsafeMutablePointer<Int8> = nil
      return format.withCString { CString in
        guard vasprintf(&buffer, CString, va_list) != 0 else {
          return nil
        }
        
        return String.fromCString(buffer)
      }
    }
  }
  
  
  //MARK:宏 略
}




