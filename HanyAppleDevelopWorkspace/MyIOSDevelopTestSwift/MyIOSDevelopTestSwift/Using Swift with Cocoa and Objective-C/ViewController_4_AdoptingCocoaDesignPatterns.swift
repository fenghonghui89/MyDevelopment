//
//  ViewController_AdoptingCocoaDesignPatterns.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/7.
//  Copyright © 2016年 MD. All rights reserved.
//4 已看

import Foundation
import UIKit
import CoreLocation
class ViewController_AdoptingCocoaDesignPatterns: UIViewController {
  override func viewDidLoad() {
    
    SerialzationClass()
  }
}

//MARK:- <<<<<< class >>>>>>


//MARK:- delegate
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
  lazy var bgView:UIView = try! UIView(frame: CGRect.zero)
  
  lazy var ISO8601DateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
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
    let fileManager = FileManager.default
    let fromURL = URL(fileURLWithPath: "/path/to/old")
    let toURL = URL(fileURLWithPath: "/path/to/new")
    
    
    do {
      try fileManager.moveItem(at: fromURL, to: toURL)
    } catch CocoaError.fileNoSuchFile {
      print("Error: no such file exists")
    } catch CocoaError.fileReadUnsupportedScheme {
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
    let fileManager = FileManager.default
    if let tmpURL = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
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
  
  dynamic var myDate = Date()
  
  func updateDate() {
    myDate = Date()
  }
}


//2.Create a global context variable.
private var myContext = 0

//3.Add an observer for the key-path, override the observeValueForKeyPath:ofObject:change:context: method, and remove the observer in deinit.
class MyObserver: NSObject {
  
  var objectToObserve = MyObjectToObserve()
  
  override init() {
    super.init()
    objectToObserve.addObserver(self, forKeyPath: "myDate", options: .new, context: &myContext)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
    if context == &myContext {
      
      if let newValue = change?[NSKeyValueChangeKey.newKey] {
        print("Date changed: \(newValue)")
      }
    } else {
      super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
  }
  
  deinit {
    objectToObserve.removeObserver(self, forKeyPath: "myDate", context: &myContext)
  }
}

//MARK:- undo 略
//MARK:- Target-Action 略
//MARK:- 单例
class Singleton{
  
//  static let sharedInstance = Singleton();
  
  static let sharedInstance:Singleton = {
    let instance = Singleton();
    //...
    return instance;
  }();

}

//MARK:- 判断对象类型或是否遵守协议 略
//MARK:- Serialization序列化 & Error Handle guard确保参数按照正确的格式传递进来 否则停止并走else
class SerialzationClass {

  init(){
    
//    let JSON = "{\"name\": \"Caffè Macs\",\"coordinates\": {\"lat\": 1.1,\"lng\":2.2},\"category\": \"Food\"}" //right
    let JSON = "{\"name\": \"Caffè Macs\",\"coordinates\": {\"lat\": \"1.1\",\"lng\":\"1.1\"},\"category\": \"Food\"}" //wrong
    let data = JSON.data(using: String.Encoding.utf8)!
    let attributes = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
    
    //错误返回nil
//    if let venue =  Venue(attributes: attributes){
//      print(venue.name)// Prints "Caffè Macs"
//    }else{
//      print("error...")
//    }
    
    //错误抛出异常
    do {
      let venue = try Venue(attributes: attributes)
      print(venue.name)// Prints "Caffè Macs"
    } catch Venue.ValidationError.missing(let field) {
      print("Missing Missing: \(field)")
    } catch Venue.ValidationError.invalid(let field) {
      print("Missing Invalid: \(field)")
    } catch{
      print("unknow error")
    }
  }
}

struct Venue {
  
  enum Category: String {
    case Entertainment
    case Food
    case Nightlife
    case Shopping
  }
  
  var name: String
  var coordinates: CLLocationCoordinate2D
  var category: Category
  
  
  //数据错误就返回nil
//  init?(attributes: [String: AnyObject]) {
//    
//    guard let name = attributes["name"] as? String,
//      let coordinates = attributes["coordinates"] as? [String: Double],
//      let latitude = coordinates["lat"],
//      let longitude = coordinates["lng"],
//      let category = Category(rawValue: attributes["category"] as? String ?? "Invalid")
//      else {
//        print("error~")
//        return nil
//    }
//    
//    self.name = name
//    self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    self.category = category
//  }
  
  //数据错误就抛出异常
  enum ValidationError:Error {
    case missing(String)
    case invalid(String)
  }
  
  init(attributes: [String:AnyObject])throws{
  
    guard let name = attributes["name"] as? String else{
      throw ValidationError.missing("name");
    }
    
    guard let coordinates = attributes["coordinates"] as? [String:Double] else{
      throw ValidationError.missing("coordinates")
    }
    
    guard let latitude = coordinates["lat"],
      let longitude = coordinates["lng"]
      else{
      throw ValidationError.invalid("coordinates")
    }
    
    guard let categoryName = attributes["category"] as? String else{
      throw ValidationError.missing("category");
    }
    
    guard let category = Category(rawValue:categoryName) else{
      throw ValidationError.invalid("category")
    }
    
    self.name = name
    self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.category = category
  }
}


//MARK:- api可用性
/*
 #available(iOS 8.0, OSX 10.10, *) 写在控制流中
 @available(iOS 8.0, OSX 10.10, *) 标识方法的可用性 常用
 星号代表潜在的未知平台
 */
class API_Availability_Class{

  init(){
    
    
    let locationManager = CLLocationManager()
    if #available(iOS 8.0, OSX 10.10, *) {
      locationManager.requestWhenInUseAuthorization()
    }

  
    let locationManager1 = CLLocationManager()
    guard #available(iOS 8.0, OSX 10.10, *) else {
      return
    }
    locationManager1.requestWhenInUseAuthorization()
    
  }
  
  
  
  @available(iOS 8.0, OSX 10.10, *)
  func useShinyNewFeature() {
    // ...
  }
  
//MARK:- 执行命令行参数(osx) 略
}
