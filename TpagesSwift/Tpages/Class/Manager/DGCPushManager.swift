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
    let tabIndex:Int
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
    
    if urlString == nil{
      return DGCPageType.DGCPageTypeURLError
    }
    
    if urlString?.isBlankString == true {
      return DGCPageType.DGCPageTypeURLError
    }
    
    let url:NSURL = NSURL(string: urlString!)!
    let scheme = url.scheme
    let host = url.host
    let relativePath = url.relativePath
    let query = url.query
    
    if scheme == "http" || scheme == "https"{
      if query == "app=cart"//购物车
        || query == "app=buyer_order&order_status=deal"//我的订单
        || query == "app=buyer_order&order_status=canceled"//取消订单
        || query == "mod=spacecp&ac=integral"//会员信息
        || query == "mod=space&do=favorite"//收藏
        || query == "mod=space&do=pm"//提醒
        || query == "mod=spacecp&ac=profile&op=password"//设置
        || relativePath == "/sign/up"//注册
        || query == "mod=logging&action=getpassword"//找回密码
      {
        dlog("推送url：会员")
        return DGCPageType.DGCPageTypeUserCenter
      }else if host == HOST_TPAGES_DEV || host == HOST_TPAGES_CN{
        dlog("推送url：T视界")
        return DGCPageType.DGCPageTypeTpages
      }else if host == HOST_MALL_DEV || host == HOST_MALL_CN{
        dlog("推送url：商城")
        return DGCPageType.DGCPageTypeMall
      }else{
        dlog("推送url：外部url")
        return DGCPageType.DGCPageTypeUnknow
      }
    }else{
      dlog("推送url：无效url")
      return DGCPageType.DGCPageTypeURLError
    }

  }
  
  func handleRemoteNotification(userInfo:NSDictionary,tabIndex:Int,pageType:DGCPageType) {
    
    //解析userinfo
    let title = "您收到一天新消息"//无法读取到标题，所以要自定义
    let content = userInfo.objectForKey("aps")?.objectForKey("alert") as! String//内容一定会有
    let urlString = userInfo.objectForKey("url")
    

    //执行的动作
    let handleBlock = {(run:Bool) -> Void in
      
      //根据tabIndex跳转
      switch tabIndex {
      case 0,1,3://跳转到tpages mall 会员
        DGCGlobalManager.sharedInstance.mainVC!.selectViewController(UInt(tabIndex))
      case 404://不跳转
        break
      default:
        break
      }
      
      //根据pageType 发出通知/打开外部浏览器/提示url错误
      switch pageType {
      case .DGCPageTypeTpages:
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_TPAGES, object: nil, userInfo: [NOTI_TRANSITION_TPAGES:urlString!])
      case .DGCPageTypeMall:
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_MALL, object: nil, userInfo: [NOTI_TRANSITION_MALL:urlString!])
      case .DGCPageTypeUserCenter:
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_USER_CENTER, object: nil, userInfo: [NOTI_TRANSITION_USER_CENTER:urlString!])
      case .DGCPageTypeUnknow:
        UIApplication.sharedApplication().openURL(NSURL(string: urlString! as! String)!)
      case .DGCPageTypeURLError:
        break
      default:
        break
      }
    }
    
    //分析app state 如果是前台则弹窗再执行 否则直接执行
    switch UIApplication.sharedApplication().applicationState {
    case UIApplicationState.Active:
      dlog("app state:前台")
      
      let ac = DGCAlertController.alertControlller(title, message: content, type: DGCAlertType.DGCAlertTypeTwoSelect, block: { (run) in
        handleBlock(true)
      })
      
      let mainVC:DGCMainViewController = DGCGlobalManager.sharedInstance.mainVC!
      mainVC.presentViewController(ac, animated: true, completion: nil)
    case UIApplicationState.Background:
      dlog("app state:后台")
      handleBlock(true)
    case UIApplicationState.Inactive:
      dlog("app state:非活跃（被中断或从后台过渡到前台中）")
      handleBlock(true)
    }
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
}