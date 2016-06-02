//
//  ViewController_AccessControl1.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/2.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_AccessControl1: UIViewController {
  
  override func viewDidLoad() {
    
    
    var stringToEdit = TrackedString()
//    stringToEdit.numberOfEdits = 4;//私有set
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
    // Prints "The number of edits is 3"
    
  }
}