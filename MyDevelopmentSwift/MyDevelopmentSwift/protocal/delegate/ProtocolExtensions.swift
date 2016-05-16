//
//  ProtocolExtensions.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/5/16.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation


//扩展协议
extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}

extension PrettyTextRepresentable  {
  var prettyTextualDescription: String {
    return textualDescription
  }
}



//给扩展协议添加约束
extension CollectionType where Generator.Element: TextRepresentable {
  var textualDescription: String {
    let itemsAsText = self.map { $0.textualDescription }
    return "[" + itemsAsText.joinWithSeparator(", ") + "]"
  }
}

