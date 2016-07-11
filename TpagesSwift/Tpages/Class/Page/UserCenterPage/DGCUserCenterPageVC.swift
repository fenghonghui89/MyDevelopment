//
//  DGCUserCenterPageVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/8.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCUserCenterPageVC: DGCBaseViewController {
  
  override init(pageType: DGCPageType) {
    super.init(pageType: pageType)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.yellowColor()
  }
}