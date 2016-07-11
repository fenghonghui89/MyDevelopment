//
//  DGCMainViewController.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/6.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DGCMainViewController: UIViewController,RDVTabBarControllerDelegate {
  

  var tabBarVC:DGCBaseTabBarController?
  var currentViewController:UIViewController{
    get{
      let navigationController = self.tabBarVC?.selectedViewController as! DGCBaseNavigationController
      return navigationController
    }
  }
  
  
  
  //MARK:- ********************** vc lifecycle
  deinit{
    removeObserver()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addObserver()
    self.commonInitTabBar()
    self.commonInitStateBar()
  }
  

  
  //MARK:- ********************** method
  //MARK:- < customize init >
  private func commonInitTabBar() {
    
    let tpagesPageVC = DGCTpagesPageVC(pageType: DGCPageType.DGCPageTypeTpages)
    let nvc_home = DGCBaseNavigationController(rootViewController: tpagesPageVC)
    
    let mallPageVC = DGCMallPageVC(pageType: DGCPageType.DGCPageTypeMall)
    let nvc_mall = DGCBaseNavigationController(rootViewController: mallPageVC)
    
    let QRCodePageVC = DGCQRCodePageVC()
    let nvc_qrcode = DGCBaseNavigationController(rootViewController: QRCodePageVC)
    
    let userCenterPageVC = DGCUserCenterPageVC(pageType:DGCPageType.DGCPageTypeUserCenter)
    let nvc_userCenter = DGCBaseNavigationController(rootViewController: userCenterPageVC)
    
    let tabbarVC:DGCBaseTabBarController = DGCBaseTabBarController()
    tabbarVC.delegate = self
    tabbarVC.viewControllers = [nvc_home,nvc_mall,nvc_qrcode,nvc_userCenter]
    self.view.addSubview(tabbarVC.view)
    tabbarVC.view.snp_makeConstraints { (make) in
      make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
    }
    self.tabBarVC = tabbarVC
    
    let unselectedImageNames = ["tab-tvision","tab-mall","tab-qr","tab-personal"]
    let selectedImageNames = ["tab-tvision","tab-mall","tab-qr","tab-personal"]
    let titles = ["T视界","商城","QR Code","会员"]
    
    for i in 0..<tabbarVC.tabBar.items.count {
      
      let item:RDVTabBarItem = tabbarVC.tabBar.items[i] as! RDVTabBarItem
      item.title = titles[i]
      
      let selectedBgImage:UIImage = UIImage(named: "tab-bg-green")!
      let unselectedBgImage:UIImage = UIImage(named: "tab-bg-grey")!
      item.setBackgroundSelectedImage(selectedBgImage, withUnselectedImage: unselectedBgImage)
      
      let selectedImage:UIImage = UIImage(named: selectedImageNames[i])!
      let unselectedImage:UIImage = UIImage(named: unselectedImageNames[i])!
      item.setFinishedSelectedImage(selectedImage, withFinishedUnselectedImage: unselectedImage)
      
      item.titlePositionAdjustment = UIOffsetMake(0, -3)
    }
    
  }
  
  private func commonInitStateBar() {
    
    let statusBarView:UIView = UIView()
    statusBarView.backgroundColor = UIColor.blackColor()
    statusBarView.tag = 101
    self.view.addSubview(statusBarView)
    
    statusBarView.snp_makeConstraints { (make) in
      make.top.equalTo(self.view).offset(0)
      make.left.equalTo(self.view).offset(0)
      make.right.equalTo(self.view).offset(-0)
      make.height.equalTo(20)
    }
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  private func addObserver() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showNetworkErrorLabel(_:)), name: NOTI_NETWORK_STATE, object: nil)
  }
  
  private func removeObserver(){
    NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTI_NETWORK_STATE, object: nil)
  }
  //MARK:- ********************** action
  func selectViewController(index:UInt){
    self.tabBarVC!.selectedIndex = index
  }
  
  func showNetworkErrorLabel(noti:NSNotification){
    

    var label:UILabel
    if let checkLabel:UILabel = self.view.viewWithTag(100) as? UILabel {
      label = checkLabel
    }else{
      label = UILabel()
      label.text = "网络不可达"
      label.sizeToFit()
      label.backgroundColor = UIColor.blackColor()
      label.alpha = 0.7
      label.layer.cornerRadius = 10
      label.clipsToBounds = true
      label.textAlignment = .Center
      label.textColor = UIColor.whiteColor()
      label.tag = 100
      self.view.addSubview(label)
      
      label.snp_makeConstraints(closure: { (make) in
        make.leading.equalTo(self.view).offset(10)
        make.trailing.equalTo(self.view).offset(-10)
        make.bottom.equalTo(self.view).offset(-(TABBAR_HEIGHT+10))
      })
    }
    
    if let _:Bool = (noti.userInfo![NOTI_NETWORK_STATE]?.boolValue)! {
      label.hidden = true
    }else{
      self.view.bringSubviewToFront(label)
      label.hidden = false
    }
    
   
  }
  
  
  //MARK:- ********************** callback
  func tabBarController(tabBarController: RDVTabBarController!, shouldSelectViewController viewController: UIViewController!) -> Bool {

    if tabBarController.selectedViewController.isEqual(viewController) {
      
      if tabBarController.selectedIndex == 2 {
        return true
      }
      
      dlog("点击了同一个tab \(tabBarController.selectedIndex)")
      
      let nvc:DGCBaseNavigationController = viewController as! DGCBaseNavigationController
      nvc.popToRootViewControllerAnimated(false)
      
      let vc:DGCBaseViewController = nvc.visibleViewController as! DGCBaseViewController
      vc.loadHomePage()
    }
    
    return true
  }
  
}