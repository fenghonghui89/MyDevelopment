//
//  AccessControl_base1.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

private func AccessControl_show1() {
  
  var stringToEdit = TrackedString()
//  stringToEdit.numberOfEdits = 4;//私有set
  stringToEdit.value = "This string will be tracked."
  stringToEdit.value += " This edit will increment numberOfEdits."
  stringToEdit.value += " So will this one."
  print("The number of edits is \(stringToEdit.numberOfEdits)")
  // Prints "The number of edits is 3"
  
}