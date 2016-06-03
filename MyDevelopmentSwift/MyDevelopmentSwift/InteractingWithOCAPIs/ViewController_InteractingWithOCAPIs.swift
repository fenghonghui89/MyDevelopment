//
//  ViewController_InteractingWithOCAPIs.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/3.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation
import UIKit

class ViewController_InteractingWithOCAPIs: UIViewController {
  
  override func viewDidLoad() {
    
  }
  
  //MARK:初始化
  func func_Initialization(){
    
    let myTableView: UITableView = UITableView(frame: CGRectZero, style: .Grouped)
    
    let myTextField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 40.0))
    
    let color = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
    
    if let image = UIImage(contentsOfFile: "MyImage.png") {
      // loaded the image successfully
    } else {
      // could not load the image
    }
    
  }
  
  //MARK:属性
  func func_AccessingProperties(){
    
    let myTextField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 40.0))
    
    myTextField.textColor = UIColor.darkGrayColor()
    myTextField.text = "Hello world"
    

  }
  
  //MARK:方法
  func func_WorkingWithMethods(){
    
    let myTableView: UITableView = UITableView(frame: CGRectZero, style: .Grouped)
    myTableView.insertSubview(UIView(), atIndex: 2)
    myTableView.layoutIfNeeded()
  }
  
  //MARK:id与anyobject互换性
  func func_idCompatibility() {
    
    var myObject: AnyObject = UITableViewCell()
    myObject = NSDate()
    let futureDate = myObject.dateByAddingTimeInterval(10)
    let timeSinceNow = myObject.timeIntervalSinceNow
    myObject.characterAtIndex(5)
    // crash, myObject doesn't respond to that method
    
    
    // myObject has AnyObject type and NSDate value
    let myCount = myObject.count
    // myCount has Int? type and nil value
    let myChar = myObject.characterAtIndex?(5)
    // myChar has unichar? type and nil value
    if let fifthCharacter = myObject.characterAtIndex?(5) {
      print("Found \(fifthCharacter) at index 5")
    }
    // conditional branch not executed
    
  }
  
  //MARK:as向下转型
  func func_DowncastingAnyObject() {
    
    //as?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let lastRefreshDate: AnyObject? = userDefaults.objectForKey("LastRefreshDate")
    if let date = lastRefreshDate as? NSDate {
      print("\(date.timeIntervalSinceReferenceDate)")
    }
    
    //as!
    let myDate = lastRefreshDate as! NSDate
    let timeInterval = myDate.timeIntervalSinceReferenceDate
    

//    let myDate = lastRefreshDate as! NSString //runtime Error
    
    let path:UIBezierPath = UIBezierPath(triangleSideLength: 1, origin: CGPointMake(1,1))
    

  }
  
  //扩展
  func func_Extensions() {
    
    let path = UIBezierPath(triangleSideLength: 2, origin: CGPointMake(50, 50))
    
    let rect = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 50.0)
    let area = rect.area
  }
  
  
  //MARK:@objc @nonobjc
  func func_objc() {
    
    
  }
  
  //MARK:oc选择器 #selector
  func func_OCSelectors() {
    
    
    let string: NSString = "Hello, Cocoa!"
    let selector = #selector(NSString.lowercaseStringWithLocale(_:))
    let locale = NSLocale.currentLocale()
    if let result = string.performSelector(selector, withObject: locale) {
      print(result.takeUnretainedValue())
    }
    // Prints "hello, cocoa!"
    
    
    
    let array: NSArray = ["delta", "alpha", "zulu"]
    
    // Not a compile-time error because NSDictionary has this selector.
    let selector1 = #selector(NSDictionary.allKeysForObject)
    
    // Raises an exception because NSArray does not respond to this selector.
    array.performSelector(selector1)
    

    let anotherSelector = #selector((UIView.insertSubview(_:atIndex:)) as (UIView)->((UIView,Int)->Void))
  }
  

}


//MARK:- <<< class >>>
//MARK: - 扩展
extension UIBezierPath {
  convenience init(triangleSideLength: CGFloat, origin: CGPoint) {
    self.init()
    let squareRoot = CGFloat(sqrt(3.0))
    let altitude = (squareRoot * triangleSideLength) / 2
    moveToPoint(origin)
    addLineToPoint(CGPoint(x: origin.x + triangleSideLength, y: origin.y))
    addLineToPoint(CGPoint(x: origin.x + triangleSideLength / 2, y: origin.y + altitude))
    closePath()
  }
}

extension CGRect {
  var area: CGFloat {
    return width * height
  }
}

//MARK:- @objc @nonobjc


@objc class SwiftClass:NSObject {
  
  
}

@objc(Color)
enum Цвет: Int {
  @objc(Red)
  case Красный
  
  @objc(Black)
  case Черный
}

@objc(Squirrel)
class Белка: NSObject {
  
  @objc(color)
  var цвет: Цвет = .Красный
  
  @objc(initWithName:)
  init (имя: String) {
    // ...
  }
  
  @objc(hideNuts:inTree:)
  func прячьОрехи(количество: Int, вДереве дерево:String) {
    // ...
  }
}

//MARK:oc选择器 #selector
class MyViewController: UIViewController {
  
  let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    let action = #selector(MyViewController.tappedButton)
    myButton.addTarget(self, action: action, forControlEvents: .TouchUpInside)
  }
  
  func tappedButton(sender: UIButton!) {
    print("tapped button")
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}


