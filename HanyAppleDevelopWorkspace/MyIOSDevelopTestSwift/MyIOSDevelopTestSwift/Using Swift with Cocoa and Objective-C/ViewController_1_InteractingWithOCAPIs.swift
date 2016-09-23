//
//  ViewController_InteractingWithOCAPIs.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/3.
//  Copyright © 2016年 MD. All rights reserved.
//1

import Foundation
import UIKit

class ViewController_InteractingWithOCAPIs: UIViewController {
  
  override func viewDidLoad() {
    
  }
  
  //MARK:初始化
  func func_Initialization(){
    
    let myTableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    
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
    
    myTextField.textColor = UIColor.darkGray
    myTextField.text = "Hello world"
    

  }
  
  //MARK:方法
  func func_WorkingWithMethods(){
    
    let myTableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    myTableView.insertSubview(UIView(), at: 2)
    myTableView.layoutIfNeeded()
  }
  
  //MARK:id与anyobject互换性
  func func_idCompatibility() {
    
    var myObject: AnyObject = UITableViewCell()
    myObject = Date() as AnyObject
    let futureDate = myObject.addingTimeInterval(10)
    let timeSinceNow = myObject.timeIntervalSinceNow
    myObject.character(at: 5)
    // crash, myObject doesn't respond to that method
    
    
    // myObject has AnyObject type and NSDate value
    let myCount = myObject.count
    // myCount has Int? type and nil value
    let myChar = myObject.character?(at: 5)
    // myChar has unichar? type and nil value
    if let fifthCharacter = myObject.character?(at: 5) {
      print("Found \(fifthCharacter) at index 5")
    }
    // conditional branch not executed
    
  }
  
  //MARK:as向下转型
  func func_DowncastingAnyObject() {
    
    //as?
    let userDefaults = UserDefaults.standard
    let lastRefreshDate: AnyObject? = userDefaults.object(forKey: "LastRefreshDate") as AnyObject?
    if let date = lastRefreshDate as? Date {
      print("\(date.timeIntervalSinceReferenceDate)")
    }
    
    //as!
    let myDate = lastRefreshDate as! Date
    let timeInterval = myDate.timeIntervalSinceReferenceDate
    

//    let myDate = lastRefreshDate as! NSString //runtime Error
    
//    let path:UIBezierPath = UIBezierPath(roundedRect: 1, cornerRadius: CGPoint(x: 1,y: 1))
    

  }
  
  //扩展
  func func_Extensions() {
    
//    let path = UIBezierPath(roundedRect: 2, cornerRadius: CGPoint(x: 50, y: 50))
//    
//    let rect = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 50.0)
//    let area = rect.area
  }
  
  
  //MARK:@objc @nonobjc
  func func_objc() {
    
    
  }
  
  //MARK:oc选择器 #selector
  func func_OCSelectors() {
    
    
//    let string: NSString = "Hello, Cocoa!"
//    let selector = #selector(NSString.lowercased(with:)(_:))
//    let locale = Locale.current
//    if let result = string.perform(selector, with: locale) {
//      print(result.takeUnretainedValue())
//    }
//    // Prints "hello, cocoa!"
//    
//    
//    
//    let array: NSArray = ["delta", "alpha", "zulu"]
//    
//    // Not a compile-time error because NSDictionary has this selector.
//    let selector1 = #selector(NSDictionary.allKeys(`for`:))
//    
//    // Raises an exception because NSArray does not respond to this selector.
//    array.perform(selector1)
//    
//
//    let anotherSelector = #selector((UIView.insertSubview(_:at:)(_:atIndex:)) as (UIView)->((UIView,Int)->Void))
  }


}


//MARK:- <<< class >>>
//MARK: - 扩展
//extension UIBezierPath {
//  convenience init(triangleSideLength: CGFloat, origin: CGPoint) {
//    self.init()
//    let squareRoot = CGFloat(sqrt(3.0))
//    let altitude = (squareRoot * triangleSideLength) / 2
//    move(to: origin)
//    addLine(to: CGPoint(x: origin.x + triangleSideLength, y: origin.y))
//    addLine(to: CGPoint(x: origin.x + triangleSideLength / 2, y: origin.y + altitude))
//    close()
//  }
//}
//
//extension CGRect {
//  var area: CGFloat {
//    return width * height
//  }
//}
//
////MARK:- @objc @nonobjc
//
//
//@objc class SwiftClass:NSObject {
//  
//  
//}

//oc调用以下编译会出错，因为类型名非acsii编码
/*
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
*/

////MARK:oc选择器 #selector
//class MyViewController: UIViewController {
//  
//  let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//  
//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    
//    let action = #selector(MyViewController.tappedButton)
//    myButton.addTarget(self, action: action, for: .touchUpInside)
//  }
//  
//  func tappedButton(_ sender: UIButton!) {
//    print("tapped button")
//  }
//  
//  required init?(coder: NSCoder) {
//    super.init(coder: coder)
//  }
//  
//
//}



