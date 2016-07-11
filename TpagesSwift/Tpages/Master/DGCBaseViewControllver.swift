//
//  DGCBaseViewControllver.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/8.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation
import UIKit

class DGCBaseViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate{
  
  //当前页面类型(T视界、商城、会员中心)
  var pageType:DGCPageType
  
  
  //判断scrollview 滑动方向
  private var contentOffsetY:CGFloat?
  private var oldContentOffsetY:CGFloat?
  private var newContentOffsetY:CGFloat?
  
  private var homePageUrlString:String?
  private var currentRequestString:String?
  private var oldRequestString:String?
  
  private var webView:UIWebView?
  
  //MARK:- ********************** vc lifecycle
  deinit{
    dlog("deinit......")
    self.removeObserver()
  }
  
 
  init(pageType:DGCPageType){
    
    self.pageType = pageType
    
    super.init(nibName: nil, bundle: nil)
    
    self.commonInitData(pageType)
    self.addObserver(pageType)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.commonInitUI()
    self.webViewFirstLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewWillDisappear(animated: Bool) {
    
    self.webView?.stringByEvaluatingJavaScriptFromString("appjs.sideMenuHide()")
    
    super.viewWillDisappear(animated)
  }
  
  //MARK:- ********************** method
  //MARK:- < customize init >
  private func commonInitUI() {
    
    let webView:UIWebView = UIWebView()
    webView.scrollView.decelerationRate = 1//加快滚动速度
    webView.scalesPageToFit = true
    webView.userInteractionEnabled = true
    webView.delegate = self
    webView.scrollView.delegate = self
    webView.backgroundColor = DGCTool.TColor(hexColor: "f2f2f2", alpha: 1)
    self.view.addSubview(webView)
    self.webView = webView
    
    self.webView?.snp_makeConstraints(closure: { (make) in
      make.edges.equalTo(self.view)
    })
    
    let header:MJRefreshNormalHeader = MJRefreshNormalHeader { 
      webView.reload()
    }
    webView.scrollView.mj_header = header
  }
  

  
  private func commonInitData(pageType:DGCPageType) {
    
    switch pageType {
    case .DGCPageTypeTpages:
      self.homePageUrlString = URL_TPAGES
      self.currentRequestString = URL_TPAGES
      self.oldRequestString = URL_TPAGES
    case .DGCPageTypeMall:
      self.homePageUrlString = URL_TPAGES_MALL
      self.currentRequestString = URL_TPAGES_MALL
      self.oldRequestString = URL_TPAGES_MALL
    case .DGCPageTypeUserCenter:
      self.homePageUrlString = URL_USER_CENTER_INTEGRAL
      self.currentRequestString = URL_USER_CENTER_INTEGRAL
      self.oldRequestString = URL_USER_CENTER_INTEGRAL
    default:
      break
    }
  }
  
  //MARK:- < 通知 > -
  private func addObserver(pageType:DGCPageType){
  
    switch pageType {
    case .DGCPageTypeTpages:
      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(openOuterURL(_:)), name: NOTI_TRANSITION_TPAGES, object: nil)
    case .DGCPageTypeMall:
      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(openOuterURL(_:)), name: NOTI_TRANSITION_MALL, object: nil)
    case .DGCPageTypeUserCenter:
      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(openOuterURL(_:)), name: NOTI_TRANSITION_USER_CENTER, object: nil)
    default:
      break;
    }
    
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshWebView), name: NOTI_TakeHeaderPhotoSuccess, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshWebViewWhenLoginOrLogout(_:)), name: NOTI_LOGIN_LOGOUT_SUCCESS, object: nil)
  }
  

  private func removeObserver(){
  
    switch self.pageType {
    case .DGCPageTypeTpages:
      NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTI_TRANSITION_TPAGES, object: nil)
    case .DGCPageTypeMall:
      NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTI_TRANSITION_MALL, object: nil)
    case .DGCPageTypeUserCenter:
      NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTI_TRANSITION_USER_CENTER, object: nil)
    default:
      break
    }
    
    NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTI_TakeHeaderPhotoSuccess, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTI_LOGIN_LOGOUT_SUCCESS, object: nil)
  }
  
  @objc private func refreshWebView(){
    self.webView?.reload();
  }
  

  @objc private func refreshWebViewWhenLoginOrLogout(notification:NSNotification){
  
    let flag:DGCPageType.RawValue = (notification.userInfo![NOTI_LOGIN_LOGOUT_SUCCESS]?.integerValue)!
    
    if flag != self.pageType.rawValue {
      dlog("登录或注销成功 刷新页面 触发的tag:\(flag),当前class:\(self.dynamicType)")
      
      let url:NSURL = NSURL(string: self.currentRequestString!)!
      let request:NSURLRequest = NSURLRequest(URL: url)
      self.webView?.loadRequest(request)
    }
  }
  
  

  @objc private func openOuterURL(notification:NSNotification){
  
    var urlString:String = ""
    
    switch self.pageType {
    case .DGCPageTypeTpages:
      urlString = notification.userInfo![NOTI_TRANSITION_TPAGES] as! String
    case .DGCPageTypeMall:
      urlString = notification.userInfo![NOTI_TRANSITION_MALL] as! String
    case .DGCPageTypeUserCenter:
      urlString = notification.userInfo![NOTI_TRANSITION_USER_CENTER] as! String
    default:
      break
    }
    
    if self.isViewLoaded() {
      let url:NSURL = NSURL(string: urlString)!
      let request:NSURLRequest = NSURLRequest(URL: url)
      self.webView?.loadRequest(request)
    }else{
      self.currentRequestString = urlString
      self.oldRequestString = urlString
    }
  }
  
  //MARK:- < ohter >
  func checkUrlIsWhichPageType(request:NSURLRequest) -> DGCPageType {
    return .DGCPageTypeUnknow
  }
  
  //MARK:- < 网页加载 >
  func loadHomePage() {
    
    let url = NSURL(string: self.homePageUrlString!)
    let request = NSURLRequest(URL: url!)
    self.webView?.loadRequest(request)
  }
  
  func webViewFirstLoad(){
    
    let url = NSURL(string: self.currentRequestString!)
    let request = NSURLRequest(URL: url!)
    self.webView?.loadRequest(request)
    
  }
  
  //MARK:- ********************** action
  
  
  @objc private func tapHandler(tap:UITapGestureRecognizer) {
    
  }
  
  //MARK:- ********************** callback
  //MARK:- < UIWebViewDelegate >
  func webViewDidStartLoad(webView: UIWebView) {

    dlog("webViewDidStartLoad \(self.dynamicType)")
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    self.webView?.scrollView.mj_header.endRefreshing()
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    
    dlog("webViewDidFinishLoad \(self.dynamicType)")
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    self.webView?.scrollView.mj_header.endRefreshing()

  }
  
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    return true
  }
  
  func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    
    dlog("didFailLoadWithError \(self.dynamicType)")
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    self.webView?.scrollView.mj_header.endRefreshing()
  }
  
  //MARK:- < UIScrollViewDelegate>
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
  }
}
