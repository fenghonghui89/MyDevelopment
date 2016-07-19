//
//  DGCGlobalManager.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/11.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCGlobalManager: NSObject {
  
  private static let kTpagesUrlKey = "kTpagesUrlKey"
  private static let kTpagesMallUrlKey = "kTpagesMallUrlKey"
  private static let kIsLoginKey = "kIsLoginKey"
  
  var mainVC:DGCMainViewController?
  
  
  static let sharedInstance:DGCGlobalManager = {
    let instance = DGCGlobalManager()
    instance.checkNetwork()
    return instance
  }()
  
  
  //MARK:- cookieg管理
  static func saveCookie(){

    let cookies_tpages = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: URL_TPAGES)!)
    let data_tpages = NSKeyedArchiver.archivedDataWithRootObject(cookies_tpages!)
    NSUserDefaults.standardUserDefaults().setObject(data_tpages, forKey: kTpagesUrlKey)
    NSUserDefaults.standardUserDefaults().synchronize()
    
    let cookie_mall = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: URL_TPAGES_MALL)!)
    let data_mall = NSKeyedArchiver.archivedDataWithRootObject(cookie_mall!)
    NSUserDefaults.standardUserDefaults().setObject(data_mall, forKey: kTpagesMallUrlKey)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  
  static func readCookie(){
  
    if let data_tpages:NSData = NSUserDefaults.standardUserDefaults().objectForKey(kTpagesUrlKey) as? NSData {
      if let cookie_tpages:NSArray = NSKeyedUnarchiver.unarchiveObjectWithData(data_tpages) as? NSArray {
        for cookie in cookie_tpages {
          dlog("读取到app cookie \(cookie)")
          NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie as! NSHTTPCookie)
        }
      }
    }
    
    if let data_mall:NSData = NSUserDefaults.standardUserDefaults().objectForKey(kTpagesMallUrlKey) as? NSData {
      if let cookie_mall:NSArray = NSKeyedUnarchiver.unarchiveObjectWithData(data_mall) as? NSArray {
        for cookie in cookie_mall {
          dlog("读取到mall cookie \(cookie)")
          NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie as! NSHTTPCookie)
        }
      }
    }
    
    
  }
  
  
  static func deleteCookie(){
  
    if let data_tpages:NSData = NSUserDefaults.standardUserDefaults().objectForKey(kTpagesUrlKey) as? NSData {
      if let cookie_tpages:NSArray = NSKeyedUnarchiver.unarchiveObjectWithData(data_tpages) as? NSArray {
        for cookie in cookie_tpages {
          dlog("清空tpages cookie \(cookie)")
          NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie(cookie as! NSHTTPCookie)
        }
      }
    }
    
    if let data_mall:NSData = NSUserDefaults.standardUserDefaults().objectForKey(kTpagesMallUrlKey) as? NSData {
      if let cookie_mall:NSArray = NSKeyedUnarchiver.unarchiveObjectWithData(data_mall) as? NSArray {
        for cookie in cookie_mall {
          dlog("清空mall cookie \(cookie)")
          NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie(cookie as! NSHTTPCookie)
        }
      }
    }
    
  }
  
  //MARK:- other
  func checkNetwork() {
    
    let monitor:AFNetworkReachabilityManager = AFNetworkReachabilityManager.sharedManager()
    monitor.setReachabilityStatusChangeBlock { (status:AFNetworkReachabilityStatus) in
      
      switch status{
      case .NotReachable:
        dlog("网络中断")
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_NETWORK_STATE, object: nil, userInfo: [NOTI_NETWORK_STATE:NSNumber(bool: false)])
      default:
        dlog("网络正常")
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_NETWORK_STATE, object: nil, userInfo: [NOTI_NETWORK_STATE:NSNumber(bool: true)])
        
      }
      
    }
    
    monitor.startMonitoring()
  }
  
  func getUserAgent() {
    
    let webview_ua:UIWebView = UIWebView(frame: CGRectZero)
    let url:NSURL  = NSURL(string: "http://tpages.cn/sign/in")!
    webview_ua.loadRequest(NSURLRequest(URL: url))
    
    let userAgent:String = webview_ua.stringByEvaluatingJavaScriptFromString("navigator.userAgent")!
    let dev:String = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone ? "iPhone":"iPad"
    let ver:String = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleInfoDictionaryVersionKey as String) as! String
    
    let userAgent_custom:String = userAgent+" (TPages_"+dev+"/"+ver+")"
    
    let dic = ["UserAgent":userAgent_custom]
    
    NSUserDefaults.standardUserDefaults().registerDefaults(dic)
    NSUserDefaults.standardUserDefaults().synchronize()
    
    dlog("UserAgent:\(userAgent_custom)")
  }
  
  
}