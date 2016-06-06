//
//  ViewController_WritingSwiftClassesWithOCBehavior.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation
import UIKit

class ViewController_WritingSwiftClassesWithOCBehavior: UIViewController {
  
  @IBOutlet weak var btn: UIButton!
  
  @IBAction func btnTap(sender: AnyObject) {
    print("tap tap tap")
  }
  
  override func viewDidLoad() {
    MySVC3().test();
    
    
    
  }
  
  //MARK:实时渲染
  func func_LiveRendering() {
    if let cv:CustomView = NSBundle.mainBundle().loadNibNamed("CustomView", owner: self, options: nil).last as? CustomView{
      cv.frame = CGRectMake(10, 10, 50, 50)
      self.view.addSubview(cv)
    }
  }
}


//MARK:NSCoding
class MyViewController1:UIViewController {
  
  var tv:protocol<UITableViewDataSource, UITableViewDelegate>
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


//MARK:协议
class MySwiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 1
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    return UITableViewCell()
  }
}



//MARK:NSClassFromString获取class
class MySVC3{

  func test() {
    
    if let SC:AnyClass = NSClassFromString("SuperClass") {
      print("have!")
    }else{
      print("no have..")
    }
    //no have..
    
    if let SC:AnyClass = NSClassFromString("MyDevelopmentSwift.SuperClass") {
      print("have!")
    }else{
      print("no have..")
    }
    //have!
    
    
    if let SC:AnyClass = NSClassFromString("OCViewController") {
      print("have!")
    }else{
      print("no have..")
    }
    //have!
    
    if let SC:AnyClass = NSClassFromString("MyDevelopmentSwift.OCViewController") {
      print("have!")
    }else{
      print("no have..")
    }
    //no have..
  }

}