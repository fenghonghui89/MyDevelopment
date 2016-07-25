//
//  AppDelegate.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  //MARK:- ********************** method **********************
  func handleOpenURL(url:NSURL) -> Bool {
    

    let urlString:String = url.absoluteString.stringByRemovingPercentEncoding!
    dlog("open url:\(urlString)")
    
    let result = DGCShareManager.sharedInstance.handleOpenURL(url)
    if result == false {
      
      //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
      if url.host! == "safepay" {
        AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (dic:[NSObject:AnyObject]!) in
          dlog("safepay result = \(dic)")
        })
      }
      
      //支付宝钱包快登授权返回 authCode
      if url.host! == "platformapi" {
        AlipaySDK.defaultService().processAuthResult(url, standbyCallback: { (dic:[NSObject:AnyObject]!) in
          dlog("platformapi result = \(dic)")
        })
      }
    }
    
    //调用其他SDK，例如新浪微博SDK等
    WXApi.handleOpenURL(url, delegate: DGCPayManager.sharedInstance)
    
    return result
  }
  //MARK:- ********************** callback **********************
  //MARK:- < app delegate >
  //MARK:app lifecycle
  func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
    openLog = true
    dlog("app state 1:willFinishLaunchingWithOptions")
    return true
  }
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    dlog("app state 2:didFinishLaunchingWithOptions")
    
    //开启离线缓存
    NSURLProtocol.registerClass(RNCachingURLProtocol)
    
    //延长闪屏图停留时间
    NSThread.sleepForTimeInterval(2)
    
    //view set
    window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
    window?.backgroundColor = UIColor.whiteColor()
    let mainVC:DGCMainViewController = DGCMainViewController()
    window?.rootViewController = mainVC;
    window?.makeKeyAndVisible()
    
    DGCGlobalManager.sharedInstance.mainVC = mainVC
    
    //打印信息
    DGCTool.showDeviceInfo()
    
    //支付
    DGCPayManager.sharedInstance.start()
    
    //友盟分享
    DGCShareManager.sharedInstance.startUMShare()

    //友盟推送
    DGCPushManager.sharedInstance.registerUMengPushInfo(launchOptions)
    DGCPushManager.sharedInstance.startPush()
    
    //user agent
    DGCGlobalManager.sharedInstance.getUserAgent()
    
    //cookie
    DGCGlobalManager.readCookie()
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    dlog("app state 4:applicationWillResignActive~")
  }

  func applicationDidEnterBackground(application: UIApplication) {
    dlog("app state 5:applicationDidEnterBackground~进入后台，保存cookie")
    DGCGlobalManager.saveCookie()
  }

  func applicationWillEnterForeground(application: UIApplication) {
    dlog("app state 6:applicationWillEnterForegroun")
  }

  func applicationDidBecomeActive(application: UIApplication) {
    dlog("app state 3 & 7:applicationDidBecomeActive")
  }

  func applicationWillTerminate(application: UIApplication) {
    dlog("app state end:applicationWillTerminate 关闭app，保存cookie")
    DGCGlobalManager.saveCookie()
  }

  
  func applicationDidReceiveMemoryWarning(application: UIApplication) {
    dlog("app state end:applicationDidReceiveMemoryWarning")
  }
  
  //MARK:open url
  //9.0 or later
  func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    return self.handleOpenURL(url)
  }
  
  //9.0以前
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return self.handleOpenURL(url)
  }
  
  func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
    return self.handleOpenURL(url)
  }
  
  
  //MARK:远程推送
  func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    dlog("远程推送 - didRegisterUserNotificationSettings")
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    DGCPushManager.sharedInstance.registerDeviceToken(deviceToken)
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    dlog("远程推送 - didReceiveRemoteNotification")
  }
  
  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    dlog("远程推送 - application:didFailToRegisterForRemoteNotificationsWithError:\(error.localizedDescription)")
  }
}

