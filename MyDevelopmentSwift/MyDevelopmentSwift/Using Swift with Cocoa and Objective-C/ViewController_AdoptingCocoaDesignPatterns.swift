//
//  ViewController_AdoptingCocoaDesignPatterns.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/7.
//  Copyright © 2016年 MD. All rights reserved.
//4

import Foundation
import UIKit

class ViewController_AdoptingCocoaDesignPatterns: UIViewController {
  override func viewDidLoad() {
    
  }
}

//MARK:- <<<<<< class >>>>>>


//MARK:delegate
//class MyDelegate: NSObject, NSWindowDelegate {
//  func window(window: NSWindow, willUseFullScreenContentSize proposedSize: NSSize) -> NSSize {
//    return proposedSize
//  }
//}
//var myDelegate: NSWindowDelegate? = MyDelegate()
//if let fullScreenSize = myDelegate?.window?(myWindow, willUseFullScreenContentSize: mySize) {
//  print(NSStringFromSize(fullScreenSize))
//}

//MARK:lazy load
class LazyInitClass{

//  lazy var XMLDocument: NSXMLDocument = try! NSXMLDocument(contentsOfURL: NSBundle.mainBundle().URLForResource("document", withExtension: "xml")!, options: 0)
  lazy var bgView:UIView = try! UIView(frame: CGRectZero)
  
  lazy var ISO8601DateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return formatter
  }()
  

}

//MARK:- Error Handling

class ErrorClass {
  
  //MARK:捕获error
  func func_CatchingAndHandlingAnError() {
    
    
    //OC
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSURL *fromURL = [NSURL fileURLWithPath:@"/path/to/old"];
//    NSURL *toURL = [NSURL fileURLWithPath:@"/path/to/new"];
//    NSError *error = nil;
//    BOOL success = [fileManager moveItemAtURL:URL toURL:toURL error:&error];
//    if (!success) {
//      NSLog(@"Error: %@", error.domain);
//    }
    

    //Swift
    let fileManager = NSFileManager.defaultManager()
    let fromURL = NSURL(fileURLWithPath: "/path/to/old")
    let toURL = NSURL(fileURLWithPath: "/path/to/new")
    
    
    do {
      try fileManager.moveItemAtURL(fromURL, toURL: toURL)
    } catch NSCocoaError.FileNoSuchFileError {
      print("Error: no such file exists")
    } catch NSCocoaError.FileReadUnsupportedSchemeError {
      print("Error: unsupported scheme (should be 'file://')")
    } catch{
      print("other error");
    }
  
  }
  
  //MARK:转变error为可选值
  func func_ConvertingErrorsToOptionalValues(){
    
    //OC代码
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSURL *tmpURL = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
//    if (tmpURL != nil) {
//      // ...
//    }
    
    //Swift
    let fileManager = NSFileManager.defaultManager()
    if let tmpURL = try? fileManager.URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true) {
      // ...
    }
    
  }
  
  //MARK:抛出异常
  func func_ThrowingAnError(){
    
    //OC
//    if (errorPtr) {
//      *errorPtr = [NSError errorWithDomain:NSURLErrorDomain
//        code:NSURLErrorCannotOpenFile
//        userInfo:nil];
//    }
    
    //swift
    func func_throw()throws{
      throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)
    }
  }
  
  
}

//MARK:- KVO

//1.Add the dynamic modifier to any property you want to observe. For more information on dynamic, see Requiring Dynamic Dispatch.
//https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID57
class MyObjectToObserve: NSObject {
  
  dynamic var myDate = NSDate()
  
  func updateDate() {
    myDate = NSDate()
  }
}


//2.Create a global context variable.
private var myContext = 0

//3.Add an observer for the key-path, override the observeValueForKeyPath:ofObject:change:context: method, and remove the observer in deinit.
class MyObserver: NSObject {
  
  var objectToObserve = MyObjectToObserve()
  
  override init() {
    super.init()
    objectToObserve.addObserver(self, forKeyPath: "myDate", options: .New, context: &myContext)
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
    if context == &myContext {
      
      if let newValue = change?[NSKeyValueChangeNewKey] {
        print("Date changed: \(newValue)")
      }
    } else {
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
  }
  
  deinit {
    objectToObserve.removeObserver(self, forKeyPath: "myDate", context: &myContext)
  }
}



