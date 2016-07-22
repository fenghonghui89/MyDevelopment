//
//  Extension.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/7.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

extension String {
  
  var md5 : String{
    let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
    let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen);
    
    CC_MD5(str!, strLen, result);
    
    let hash = NSMutableString();
    for i in 0 ..< digestLen {
      hash.appendFormat("%02x", result[i]);
    }
    result.destroy();
    
    return String(format: hash as String)
  }
  
  var isBlankString:Bool{
    
    if self.isEmpty {
      return true
    }
    
    if self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count == 0 {
      return true
    }
    
    return false
  }
  
}


extension AVCaptureVideoOrientation {
  var uiInterfaceOrientation: UIDeviceOrientation {
    get {
      switch self {
      case .LandscapeLeft:        return .LandscapeLeft
      case .LandscapeRight:       return .LandscapeRight
      case .Portrait:             return .Portrait
      case .PortraitUpsideDown:   return .PortraitUpsideDown
      }
    }
  }
  
  init(ui:UIDeviceOrientation) {
    switch ui {
    case .LandscapeRight:       self = .LandscapeRight
    case .LandscapeLeft:        self = .LandscapeLeft
    case .Portrait:             self = .Portrait
    case .PortraitUpsideDown:   self = .PortraitUpsideDown
    default:                    self = .Portrait
    }
  }
}


extension NSIndexSet{
  
  func aapl_indexPathsFromIndexesWithSection(section:Int) -> NSArray? {

    let indexPaths:NSMutableArray? = NSMutableArray(capacity: self.count)
    self.enumerateIndexesUsingBlock { (idx:Int, stop:UnsafeMutablePointer<ObjCBool>) in
      indexPaths!.addObject(NSIndexPath(forItem: idx, inSection: section))
    }
    return indexPaths
  }
}



extension UICollectionView{

  func aapl_indexPathsForElementsInRect(rect:CGRect) -> NSArray? {
    
    let allLayoutAttributes:[UICollectionViewLayoutAttributes]? = self.collectionViewLayout.layoutAttributesForElementsInRect(rect)
    if allLayoutAttributes == nil && allLayoutAttributes!.count == 0 {
      return nil
    }
    
    let indexPaths:NSMutableArray = NSMutableArray(capacity: allLayoutAttributes!.count)
    for layoutAttributes:UICollectionViewLayoutAttributes in allLayoutAttributes! {
      let indexPath:NSIndexPath = layoutAttributes.indexPath
      indexPaths.addObject(indexPath)
    }
    
    return indexPaths
  }
  

}










