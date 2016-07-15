//
//  DGCPushManager.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/11.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCPushManager: NSObject {
  
  var tokenIsChanged:Bool?

  //MARK:- start / stop
  static let sharedInstance:DGCPushManager = {
  
    let instance = DGCPushManager()
    return instance
  }()
  
  func registerUMengPushInfo(launchOptions:NSDictionary){
    
    UMessage.startWithAppkey(UMENG_APPKEY, launchOptions: launchOptions as [NSObject : AnyObject])
    
    //如果app处于未运行时受到推送，点击通知打开app之后会有userInfo
    if let userInfo = launchOptions.objectForKey(UIApplicationLaunchOptionsRemoteNotificationKey) {
      self.didReceiveRemoteNotification(userInfo as! NSDictionary)
    }
  }
  
  func startPush(){
    
    //log
    UMessage.setLogEnabled(true)
    
    //清楚角标和通知
    UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    UIApplication.sharedApplication().cancelAllLocalNotifications()
    
    //other
    UMessage.setBadgeClear(true)
    UMessage.setAutoAlert(false)
    UMessage.setChannel("App Store")
    
    //注册推送
    UMessage.registerForRemoteNotifications()
  }
  
  //MARK:- 注册/注销推送服务
  func stopPush(){
    UMessage.unregisterForRemoteNotifications()
  }
  
  //MARK:- 注册 device token / 发送token到服务器
  func registerDeviceToken(deviceToken:NSData){
    
    //修改token
    var dt = deviceToken.description.stringByReplacingOccurrencesOfString("<", withString: "")
    dt = dt.stringByReplacingOccurrencesOfString(">", withString: "")
    dt = dt.stringByReplacingOccurrencesOfString(" ", withString: "")
    dlog("设备token:\(dt)")
    
    //判断 保存 token
    if let dtOld = NSUserDefaults.standardUserDefaults().objectForKey("deviceToken") as? String {
      if dtOld == dt {
        dlog("token一样")
        self.tokenIsChanged = false
      }else{
        dlog("token不一样")
        self.tokenIsChanged = true
        NSUserDefaults.standardUserDefaults().setObject(dt, forKey: "deviceToken")
        NSUserDefaults.standardUserDefaults().synchronize()
      }
    }else{
      dlog("第一个token")
      self.tokenIsChanged = true
      NSUserDefaults.standardUserDefaults().setObject(dt, forKey: "deviceToken")
      NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    UMessage.registerDeviceToken(deviceToken)
    
  }
  
  func sendTokenToServer(){
    
    var requestStr = URL_TPAGES.stringByAppendingString("/home.php?mod=spacecp&ac=devicetoken&device=ios&token=")
    let token = NSUserDefaults.standardUserDefaults().objectForKey("deviceToken") as! String
    requestStr = requestStr.stringByAppendingString(token)
    let url = NSURL(string: requestStr)
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "GET"
    dlog("发送token requestStr:\(requestStr)")
    
    let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
    let manager = AFURLSessionManager(sessionConfiguration: conf)
    let responseSerializer = AFHTTPResponseSerializer()
    responseSerializer.acceptableContentTypes = ["application/json"]
    manager.responseSerializer = responseSerializer
    

    let dataTask = manager.dataTaskWithRequest(request, uploadProgress: nil, downloadProgress: nil) {
      (response:NSURLResponse, responseObject:AnyObject?, error:NSError?)->Void in

      if (error != nil){
        dlog("发送token error msg:\(error?.description)")
      }else{
        do{
          let dic = try NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.AllowFragments)
          self.tokenIsChanged = false
          dlog("发送token success JSON:\(dic.objectForKey("status") as! String) \(dic.objectForKey("msg") as! String)")
        }catch{
          dlog("发送token fail JSON")
        }
      }

    }
    
    dataTask.resume()
    
    
  }
  
  //MARK:- 接收到推送
  func didReceiveRemoteNotification(userInfo:NSDictionary){
    
    //umeng
    UMessage.didReceiveRemoteNotification(userInfo as [NSObject : AnyObject])
    UMessage.sendClickReportForRemoteNotification(userInfo as [NSObject : AnyObject])
    
    //分析推送
    self.checkRemoteNotification(userInfo)
  }
  
  
  func checkRemoteNotification(userInfo:NSDictionary) {
    
    //解析推送
    let tabString = userInfo.objectForKey("tab") as? String
    let urlString = userInfo.objectForKey("url") as? String
    let content = userInfo.objectForKey("aps")?.objectForKey("alert") as? String
    dlog("解析推送 userinfo:\(userInfo)")
    dlog("解析推送 content:\(content) url:\(urlString) tag:\(tabString)")
    
    //分析tab
    var tabIndex:Int
    if tabString == "tv" {
      dlog("推送tab:T视界")
      tabIndex = 0
    }else if tabString == "mall"{
      dlog("推送tab:商城")
      tabIndex = 1
    }else if tabString == "member"{
      dlog("推送tab:会员")
      tabIndex = 3
    }else{
      dlog("推送tab:没有tab 或者tab标识错误")
      tabIndex = 404
    }
    
    //分析url
    let pageType = self.checkURL(urlString!)
    
    //处理推送
    self.handleRemoteNotification(userInfo, tabIndex: tabIndex, pageType: pageType)
    
  }
  
  func checkURL(urlString:String?) -> DGCPageType {
    
//    //如果url为空 则直接返回错误类型
//    if (urlString == nil || [urlString isBlankString]) {
//      DRLog(@"推送url：没有url");
//      return DGCPageTypeURLError;
//    }
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSString *scheme = url.scheme;
//    NSString *host = url.host;
//    NSString *relativePath = url.relativePath;// /a/4003.html
//    NSString *query = url.query;
//    
//    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
//      if (
//        [query isEqualToString:@"app=cart"]//购物车
//        || [query isEqualToString:@"app=buyer_order&order_status=deal"]//我的订单
//        || [query isEqualToString:@"app=buyer_order&order_status=canceled"]//取消订单
//        || [query isEqualToString:@"mod=spacecp&ac=integral"]//会员信息
//        || [query isEqualToString:@"mod=space&do=favorite"]//收藏
//        || [query isEqualToString:@"mod=space&do=pm"]//提醒
//        || [query isEqualToString:@"mod=spacecp&ac=profile&op=password"]//设置
//        || [relativePath isEqualToString:@"/sign/up"]//注册
//        || [query isEqualToString:@"mod=logging&action=getpassword"]//找回密码
//        )
//      {
//        DRLog(@"推送url：会员");
//        return DGCPageTypeUserCenter;
//      }else if ([host isEqualToString:HOST_TPAGES_DEV] || [host isEqualToString:HOST_TPAGES_CN]) {
//        DRLog(@"推送url：T视界");
//        return DGCPageTypeTpages;
//      }else if ([host isEqualToString:HOST_MALL_DEV] || [host isEqualToString:HOST_MALL_CN]) {
//        DRLog(@"推送url：商城");
//        return DGCPageTypeMall;
//      }else{
//        DRLog(@"推送url：外部url");
//        return DGCPageTypeUnknow;
//      }
//    }else{
//      DRLog(@"推送url：无效url");
//      return DGCPageTypeURLError;
//    }
    
    if urlString == nil{
      return DGCPageType.DGCPageTypeURLError
    }
    
    if urlString?.isBlankString == true {
      return DGCPageType.DGCPageTypeURLError
    }
    
    return DGCPageType.DGCPageTypeMall
  }
  
  func handleRemoteNotification(userInfo:NSDictionary,tabIndex:Int,pageType:DGCPageType) {
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
}