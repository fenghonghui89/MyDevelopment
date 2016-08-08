//
//  DGCBaseViewControllver.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/8.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation
import UIKit

class DGCBaseViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate,DGCPayManagerDelegate{
  
  //当前页面类型(T视界、商城、会员中心)
  var pageType:DGCPageType
  
  
  //判断scrollview 滑动方向
  private var contentOffsetY:CGFloat?
  private var oldContentOffsetY:CGFloat?
  private var newContentOffsetY:CGFloat?
  
  private var homePageUrlString:String?
  private var currentRequestString:String?
  
  private var webView:UIWebView?
  
  //MARK:- ********************** vc lifecycle **********************
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
    
    //关闭侧栏
    self.webView?.stringByEvaluatingJavaScriptFromString("appjs.sideMenuHide()")
    
    //关闭登录框
    self.webView?.stringByEvaluatingJavaScriptFromString("appjs.modalHide()")
    
    super.viewWillDisappear(animated)
  }
  
  //MARK:- ********************** method **********************
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
    case .DGCPageTypeMall:
      self.homePageUrlString = URL_TPAGES_MALL
      self.currentRequestString = URL_TPAGES_MALL
    case .DGCPageTypeUserCenter:
      self.homePageUrlString = URL_USER_CENTER_INTEGRAL
      self.currentRequestString = URL_USER_CENTER_INTEGRAL
    default:
      break
    }
  }
  
  //MARK:- < 通知 >
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
    }
  }
  
  //MARK:- < ohter >
  
  func URLDecodedStringByString(originalString:String) -> String {

    let result = originalString.stringByRemovingPercentEncoding
    return result!
  }
  
  func dataToJsonString(object:AnyObject) -> String {
    
    var jsonString:String = ""
    
    do{
      let jsonData:NSData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
      jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
      return jsonString
    }catch {
      dlog("DataToJsonString error")
    }
    
    return jsonString
  }
  
  func checkUrlIsWhichPageType(request:NSURLRequest) -> DGCPageType {
    //页面间跳转逻辑，tpages 商城 会员 重写这个方法
    return .DGCPageTypeUnknow
  }
  
  func checkIsLogin() {
    
    let content:NSString = self.webView!.stringByEvaluatingJavaScriptFromString("dzuid")! as NSString
    let newUid:Int = content.integerValue
    let oldUid:Int = NSUserDefaults.standardUserDefaults().integerForKey("dzuid")
    
    if newUid > 0 {
      dlog("dzuid>0 登录了")
      if newUid != oldUid {
        dlog("登录成功 发送token 发通知刷新其他页面 \(self.dynamicType)")
        DGCPushManager.sharedInstance.sendTokenToServer()
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_LOGIN_LOGOUT_SUCCESS, object: nil, userInfo: [NOTI_LOGIN_LOGOUT_SUCCESS:NSNumber(integer: self.pageType.rawValue)])
      }else{
        if (DGCPushManager.sharedInstance.tokenIsChanged == true) {
          dlog("已经登录，token改变了，发送最新的token \(self.dynamicType)")
          DGCPushManager.sharedInstance.sendTokenToServer()
        }else{
          dlog("已经登录，token没有改变，不发送token \(self.dynamicType)");
        }
      }
    }
    
    else{
      dlog("dzuid=0 未登录")
      if newUid != oldUid {
        dlog("注销成功 发通知刷新其他页面 删除cookie \(self.dynamicType)")
        DGCGlobalManager.deleteCookie()
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_LOGIN_LOGOUT_SUCCESS, object: nil, userInfo: [NOTI_LOGIN_LOGOUT_SUCCESS:NSNumber(integer: self.pageType.rawValue)])
      }
    }
    
    NSUserDefaults.standardUserDefaults().setInteger(newUid, forKey: "dzuid")
    NSUserDefaults.standardUserDefaults().synchronize()
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
  
  //MARK:- ********************** action **********************
  //MARK:- < 支付 >
  func AliPay(dic:NSDictionary) {
    
    DGCPayManager.sharedInstance.delegate = self
    DGCPayManager.sharedInstance.Alipay(dic)
  }
  
  func WXPay(dic:NSDictionary)  {

    if DGCPayManager.sharedInstance.isWXAppInstalled() == false{
      let ac = DGCAlertController.alertControlller("进入兑换流程失败", message: "没有安装微信客户端，请先安装。", type: DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
      self.presentViewController(ac, animated: true, completion: nil)
    }else{
      DGCPayManager.sharedInstance.delegate = self
      DGCPayManager.sharedInstance.WXSendPay(dic)
    }
    
  }
  
  
  func pay(request:NSURLRequest) {
    
    let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
    let manager = AFURLSessionManager(sessionConfiguration: conf)
    let responseSerializer = AFHTTPResponseSerializer()
    responseSerializer.acceptableContentTypes = ["text/html"]
    manager.responseSerializer = responseSerializer
    
    let dataTask = manager.dataTaskWithRequest(request, uploadProgress: nil, downloadProgress: nil) {
      (response:NSURLResponse, responseObject:AnyObject?, error:NSError?)->Void in
      
      if error != nil{
        dlog("进入兑换流程失败:\(error?.description)")
        let ac = DGCAlertController.alertControlller("进入兑换流程失败", message: (error?.description)!, type: DGCAlertType.DGCAlertTypeJustConfirm, block:nil)
        self.presentViewController(ac, animated: true, completion: nil)
      }else{
        do{
          let dic = try NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.AllowFragments)
          dlog("进入兑换流程成功 dic:\(dic)")
          let status = dic.objectForKey("status") as! String
          if status == "success"{
            let type = dic.objectForKey("type") as! String
            if type == "wxpay"{
              self.WXPay(dic as! NSDictionary)
            }else{
              self.AliPay(dic as! NSDictionary)
            }
          }
        }catch{
          dlog("进入兑换流程失败：数据错误无法解析")
        }
      }
    }
    
    dataTask.resume()
    
  }
  
  //MARK:- < 第三方登录 >
  func weiboLogin() {
    
    DGCShareManager.sharedInstance.weiboLogin(self) { (paramDic) in
      
      //参数dic - json - utf8 - base64
      let newDic = NSMutableDictionary(dictionary: paramDic)
      newDic.setObject(self.currentRequestString!, forKey: "referer")
      let jsonStr:String = self.dataToJsonString(newDic)
      let jsonStrData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)
      let jsonStrBase64:String = jsonStrData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
      dlog("新浪微博用户信息jsonStr:\(jsonStr)")
      dlog("新浪微博用户信息jsonStrBase64:\(jsonStrBase64)")

      //拼接请求并发送
      let urlStrBase64:String = URL_Third_Login.stringByAppendingString(jsonStrBase64 as String)
      let url:NSURL? = NSURL(string: urlStrBase64)
      if url != nil{
        let reuqest:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        reuqest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        reuqest.HTTPMethod = "GET"
        reuqest.setValue("application/json", forHTTPHeaderField: "Accept")
        self.webView?.loadRequest(reuqest)
        dlog("新浪微博登录跳转urlStrBase64:\(urlStrBase64)")
      }else{
        dlog("新浪微博登录失败：error url")
      }

    }
  }

  func qqLogin() {
    
    DGCShareManager.sharedInstance.qqLogin(self) { (paramDic) in
      
      //参数dic - json - utf8 - base64
      let newDic = NSMutableDictionary(dictionary: paramDic)
      newDic.setObject(self.currentRequestString!, forKey: "referer")
      let jsonStr:String = self.dataToJsonString(newDic)
      let jsonStrData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)
      let jsonStrBase64:String = jsonStrData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
      dlog("QQ用户信息jsonStr:\(jsonStr)")
      dlog("QQ用户信息jsonStrBase64:\(jsonStrBase64)")
      
      //拼接请求并发送
      let urlStrBase64:String = URL_Third_Login.stringByAppendingString(jsonStrBase64 as String)
      let url:NSURL? = NSURL(string: urlStrBase64)
      if url != nil{
        let reuqest:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        reuqest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        reuqest.HTTPMethod = "GET"
        reuqest.setValue("application/json", forHTTPHeaderField: "Accept")
        self.webView?.loadRequest(reuqest)
        dlog("QQ登录跳转urlStrBase64:\(urlStrBase64)")
      }else{
        dlog("QQ登录失败：error url")
      }

    }
  }
  
  func weChatLogin() {
    
    DGCShareManager.sharedInstance.wechatLogin(self) { (paramDic) in
      
      //参数dic - json - utf8 - base64
      let newDic = NSMutableDictionary(dictionary: paramDic)
      newDic.setObject(self.currentRequestString!, forKey: "referer")
      let jsonStr:String = self.dataToJsonString(newDic)
      let jsonStrData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)
      let jsonStrBase64:String = jsonStrData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
      dlog("微信用户信息jsonStr:\(jsonStr)")
      dlog("微信用户信息jsonStrBase64:\(jsonStrBase64)")
      
      //拼接请求并发送
      let urlStrBase64:String = URL_Third_Login.stringByAppendingString(jsonStrBase64 as String)
      dlog("微信urlbaset64str:\(urlStrBase64)")
      let url:NSURL? = NSURL(string: urlStrBase64)
      if url != nil{
        let reuqest:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        reuqest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        reuqest.HTTPMethod = "GET"
        reuqest.setValue("application/json", forHTTPHeaderField: "Accept")
        self.webView?.loadRequest(reuqest)
        dlog("微信登录跳转urlStrBase64:\(urlStrBase64)")
      }else{
        dlog("微信登录失败：error url")
      }
      
    }
  }
  
  //MARK:- < share >
  func share(request:NSURLRequest)  {
    
    self.rdv_tabBarController.setTabBarHidden(true, animated: true)
    
    let fragment:String = self.URLDecodedStringByString(request.URL!.fragment!)
    let data:NSData = fragment.dataUsingEncoding(NSUTF8StringEncoding)!
    
    let dic = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
    if dic != nil {
      let title:String = (dic?.objectForKey("title"))! as! String
      let content:String = (dic?.objectForKey("content"))! as! String
      let url:String = dic?.objectForKey("url") as! String
      let imageUrl:String = dic?.objectForKey("img") as! String
      
      dlog("进入分享流程成功 title:\(title) content:\(content) url:\(url) img:\(imageUrl)")
      DGCShareManager.sharedInstance.share(self, title: title, shareText: content, url: url, imgUrl: imageUrl)
    }else{
      dlog("进入分享流程失败：json解析错误")
    }
  }
  
  //MARK:- < 拍照 >
  func takeHeadPhoto() {
    
    let hpvc:DGCHeaderPhotoVC = DGCHeaderPhotoVC(nibName: "DGCHeaderPhotoVC", bundle: nil)
    hpvc.isTakeHeaderOrBanner = true
    self.navigationController?.pushViewController(hpvc, animated: true)
  }
  
  func takeBanner() {
    
    let hpvc:DGCHeaderPhotoVC = DGCHeaderPhotoVC(nibName: "DGCHeaderPhotoVC", bundle: nil)
    hpvc.isTakeHeaderOrBanner = false
    self.navigationController?.pushViewController(hpvc, animated: true)
  }

  //MARK:- ********************** callback **********************
  //MARK:- < DGCPayManagerDelegate >
  func payManagerResult(url: NSURL) {

    dlog("支付跳转url:\(url)")
    let request:NSURLRequest = NSURLRequest(URL: url)
    self.webView?.loadRequest(request)
  }
  
  //MARK:- < UIWebViewDelegate >
  func webViewDidStartLoad(webView: UIWebView) {

    dlog("webViewDidStartLoad \(self.dynamicType)")
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    self.webView?.scrollView.mj_header.endRefreshing()
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    
    //log
    self.currentRequestString = webView.request!.URL?.absoluteString
    dlog("webViewDidFinishLoad \(self.dynamicType) 当前页面：\(self.currentRequestString)")
    
    
    //ui
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    self.webView?.scrollView.mj_header.endRefreshing()

    //加载完判断登录状态 - 打开推送
    self.checkIsLogin()
    
    //禁用长按弹出框
    self.webView?.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitTouchCallout = 'none';")
    
    //禁用用户选择
    self.webView?.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect = 'none';")
  }
  
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    
    //log
    var requestStr:String?
    var host:String?
    var relativePath:String?
    var query:String?
    var firstParam:String?
    var params:[String]?
    var scheme:String?
    
    if let url = request.URL {
      requestStr = url.absoluteString
      host = url.host
      relativePath = url.relativePath
      query = url.query
      scheme = url.scheme
      if query != nil {
        params = query?.componentsSeparatedByString("&")
        if params?.count>0{
          firstParam = params![0]
        }
      }
    }
    
    dlog("~~~ shouldStartLoadWithRequest host:\(host) relativePath:\(relativePath) firstParam:\(firstParam) requestStr:\(requestStr) type:\(navigationType) scheme:\(scheme)")
    
    //判断是否跳转到其他tab
    let urlPageType = self.checkUrlIsWhichPageType(request)
    if urlPageType != self.pageType {
      switch urlPageType {
      case .DGCPageTypeTpages:
        dlog("当前class:\(self.dynamicType) 将要切换到T视界")
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_TPAGES, object: nil, userInfo: [NOTI_TRANSITION_TPAGES:requestStr!])
        self.rdv_tabBarController.selectedIndex = 0
        return false
      case .DGCPageTypeMall:
        dlog("当前class:\(self.dynamicType) 切换到商城")
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_MALL, object: nil, userInfo: [NOTI_TRANSITION_MALL:requestStr!])
        self.rdv_tabBarController.selectedIndex = 1
        return false
      case .DGCPageTypeUserCenter:
        dlog("当前class:\(self.dynamicType) 切换到会员中心")
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_USER_CENTER, object: nil, userInfo: [NOTI_TRANSITION_USER_CENTER:requestStr!])
        self.rdv_tabBarController.selectedIndex = 3
        return false
      case .DGCPageTypeUnknow:
        dlog("当前class:\(self.dynamicType) 页面未知属于哪一类，或者属于登录登出流程，或者与当前页面类型一样，当前tab显示")
      default:
        break
      }
    }else{
      dlog("当前class:\(self.dynamicType) 类型跟当前页面类型一样，不用切换，当前tab显示")
    }
    
    //take header photo
    if host == "TPagesApp.TakeHeaderPhoto" {
      self.takeHeadPhoto()
      return false
    }
    
    //take banner photo
    if host == "TPagesApp.TakeBanner" {
      self.takeBanner()
      return false
    }
    
    //share
    if host == "TPagesApp.Share"{
      self.share(request)
      return false
    }
    
    //third login
    if host == "TPagesApp.WeiboLogin"{
      self.weiboLogin()
      return false
    }
    if host == "TPagesApp.QQLogin"{
      self.qqLogin()
      return false
    }
    if host  == "TPagesApp.WeChatLogin"{
      self.weChatLogin()
      return false
    }
    
    //图片预览
    if host == "TPagesApp.OpenImg"{
      dlog("打开了图片预览")
      self.rdv_tabBarController.setTabBarHidden(true, animated: true)
      return false
    }
    
    if host == "TPagesApp.CloseImg"{
      dlog("关闭了图片预览")
      return false
    }
    
    //pay
    if host == URL_TPAGES_MALL.stringByReplacingOccurrencesOfString("http://", withString: "")
      && relativePath == "/index.php"
      && firstParam == "app=cashier"{
      self.pay(request)
      return false
    }

    
    //logout
    if relativePath == "/sign/out"{
      if (params != nil && params?.count != 0) {
        dlog("自己加参数的注销，不处理");
      }else{
        dlog("默认注销，添加referer再重新请求 当前页面：\(self.currentRequestString)");
        
        let encodeRefererString = self.currentRequestString?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
        let signOutString = URL_TPAGES.stringByAppendingString("/sign/out?referer=\(encodeRefererString!)")
        let request = NSURLRequest(URL: NSURL(string: signOutString)!)
        self.webView?.loadRequest(request)
        return false
      }
    }
    
    
    return true;

  }
  
  func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    
    dlog("didFailLoadWithError \(self.dynamicType)")
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    self.webView?.scrollView.mj_header.endRefreshing()
  }
  
  //MARK:- < UIScrollViewDelegate>
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    self.contentOffsetY = scrollView.contentOffset.y;
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    self.newContentOffsetY = scrollView.contentOffset.y;
    
    if (newContentOffsetY > oldContentOffsetY && oldContentOffsetY > contentOffsetY) {//向上滚动
      //    DLog(@"up");
    } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) {//向下滚动
      //    DLog(@"down");
    } else {
      //    DLog(@"dragging");
    }
    
    if (scrollView.dragging) {//拖拽
      if ((scrollView.contentOffset.y - self.contentOffsetY!) > 5.0) {//向上拖拽
        self.rdv_tabBarController.setTabBarHidden(true, animated: true)
      } else if ((self.contentOffsetY! - scrollView.contentOffset.y) > 5.0) {//向下拖拽
        self.rdv_tabBarController.setTabBarHidden(false, animated: true)
      } else {
        
      }
    }
    
    //到底部就停止拖动
    if ((scrollView.contentOffset.y+SCREEN_HEIGHT) >= scrollView.contentSize.height) {
      scrollView.bounces = false
    }else{
      scrollView.bounces = true
    }
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.oldContentOffsetY = scrollView.contentOffset.y;
    
    if ((scrollView.contentOffset.y+SCREEN_HEIGHT) >= scrollView.contentSize.height) {
      scrollView.bounces = false
    }else{
      scrollView.bounces = true
    }
  }
}
