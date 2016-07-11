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
  
  static let sharedInstance:DGCGlobalManager = {
    let instance = DGCGlobalManager()
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
  
/*
     NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kTpagesUrlKey];
     if ([data length]) {
     NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
     for (NSHTTPCookie *cookie in array) {
     DRLog(@"清空tpages cookie");
     [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
     }
     }
     
     NSData *dataMall = [[NSUserDefaults standardUserDefaults] objectForKey:kMallTapgesUrlKey];
     if ([dataMall length]) {
     NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:dataMall];
     for (NSHTTPCookie *cookie in array) {
     DRLog(@"清空mall cookie");
     [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
     }
     }
     */
    
    
  }
  
  
  
  
}