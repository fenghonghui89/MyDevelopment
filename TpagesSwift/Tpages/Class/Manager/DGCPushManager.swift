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
        }catch let error as NSError{
          dlog("发送token fail JSON")
        }
      }

    }
    
    dataTask.resume()
    
    
  }
  
  //MARK:- 接收到推送
  func didReceiveRemoteNotification(userInfo:NSDictionary){
    
  }
  
  
  
  
}