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
  
  
//  override func viewDidLoad() {
//    
//    sizeofTest()
//  
//  }
//  
//  
//  //MARK:Constant Pointers
//  func pointTest0() {
//
////    var x: Float = 0.0
////    var p: UnsafePointer<Float> = nil
////    takesAPointer(nil)
////    takesAPointer(p)
////    takesAPointer(&x)
////    takesAPointer([1.0, 2.0, 3.0])
//
//    
//    //UnsafePointer<Type>
//    var x: Float = 0.0, y: Int = 0
//    var p: UnsafePointer<Float>? = nil, q: UnsafePointer<Int>? = nil
//    takesAVoidPointer(nil)
//    takesAVoidPointer(p!)
//    takesAVoidPointer(q!)
//    takesAVoidPointer(&x)
//    takesAVoidPointer(&y)
//    takesAVoidPointer([1.0, 2.0, 3.0] as [Float])
//    let intArray = [1, 2, 3]
//    takesAVoidPointer(intArray)
//    
//
//  }
//  
//  func takesAPointer(_ x: UnsafePointer<Float>) {
//    // ...
//  }
//  
//  func takesAVoidPointer(_ x: UnsafeRawPointer)  {
//    // ...
//  }
//  
//
//  
//  //MARK:Mutable Pointers
// 
//  func pointTest1() {
//    
//    var x: Float = 0.0, y: Int = 0
//    var p: UnsafeMutablePointer<Float>? = nil, q: UnsafeMutablePointer<Int>? = nil
//    var a: [Float] = [1.0, 2.0, 3.0], b: [Int] = [1, 2, 3]
//    takesAMutableVoidPointer(nil)
//    takesAMutableVoidPointer(p!)
//    takesAMutableVoidPointer(q!)
//    takesAMutableVoidPointer(&x)
//    takesAMutableVoidPointer(&y)
//    takesAMutableVoidPointer(&a)
//    takesAMutableVoidPointer(&b)
//    
//  }
//  
//  
//  func takesAMutableVoidPointer(_ x: UnsafeMutableRawPointer)  {
//    // ...
//  }
//  
//
//  //MARK:Autoreleasing Pointers
//  func pointTest2() {
//    
//    var x: Date? = nil
//    var p: AutoreleasingUnsafeMutablePointer<Date?>? = nil
//    takesAnAutoreleasingPointer(nil)
//    takesAnAutoreleasingPointer(p!)
//    takesAnAutoreleasingPointer(&x)
//    
//  }
//  
//  
//  func takesAnAutoreleasingPointer(_ x: AutoreleasingUnsafeMutablePointer<Date?>) {
//    // ...
//  }
//  
//
//  //MARK:Function Pointers
//  func pointTest3() {
//    
////    var callbacks = CFArrayCallBacks(
////      version: 0,
////      retain: nil,
////      release: nil,
////      copyDescription: customCopyDescription,
////      equal: { p1, p2 -> DarwinBoolean in
////        // return Bool value
////      }
////    )
////    
////    var mutableArray = CFArrayCreateMutable(nil, 0, &callbacks)
//  }
//  
//  func customCopyDescription(_ p: UnsafeRawPointer) -> Unmanaged<CFString>! {
//    // return an Unmanaged<CFString>! value
//    return nil;
//  }
//  
//  
//  //MARK:Data Type Size Calculation
//  func sizeofTest() {
//    
//    //不包括跟内存校准有关的填充物
//    print(MemoryLayout<timeval>.size)
//    print(MemoryLayout.size(ofValue: timeval))
//    
//    //跟c的sizeof 一致
//    print(MemoryLayout<timeval>.stride)
//    print(MemoryLayout.stride(ofValue: timeval))
//    
//    //例子
//    let sockfd = socket(AF_INET, SOCK_STREAM, 0)
//    var optval = timeval(tv_sec: 30, tv_usec: 0)
//    let optlen = socklen_t(MemoryLayout<timeval>.stride)
//    if setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &optval, optlen) == 0 {
//      // ...
//    }
//    
//
//  }
//  
//  
//  //MARK:Variadic Functions
//  func kl_VariadicFunctions() {
//    
//    print(sprintf("√2 ≅ %g", sqrt(2.0))!)
//    // Prints "√2 ≅ 1.41421"
//  }
//  
//  func sprintf(_ format: String, _ args: CVarArg...) -> String? {
//    return withVaList(args) { va_list in
//      var buffer: UnsafeMutablePointer<Int8>? = nil
//      return format.withCString { CString in
//        guard vasprintf(&buffer, CString, va_list) != 0 else {
//          return nil
//        }
//        
//        return String(cString: buffer!)
//      }
//    }
//  }
//  
//  
//  //MARK:宏 略
}




