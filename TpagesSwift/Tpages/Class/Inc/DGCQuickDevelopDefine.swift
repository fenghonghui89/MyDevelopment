//
//  DGCQuickDevelopDefine.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/7.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation
import UIKit

//MARK:- *************** method ***************

var openLog = false

func dlog(message:String = "",file:String = #file,function:String = #function,lineNum:Int = #line){
  
  if openLog != true {
    return;
  }
  
  if let fileName:String = file.componentsSeparatedByString("/").last {
    #if DEBUG
      print("[\(fileName) \(function) \(lineNum)] \(message)")
    #else
      
    #endif
  }else{
    #if DEBUG
      print("[\(file) \(function) \(lineNum)] \(message)")
    #else
      
    #endif
  }
}







//MARK:- *************** 全局常量 ***************
//MARK:- < 常用数值 >
let DGC_KEY_WINDOW:UIWindow = UIApplication.sharedApplication().keyWindow!

let SCREEN_BOUNDS = UIScreen.mainScreen().bounds
let SCREEN_WIDTH:CGFloat = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT:CGFloat = UIScreen.mainScreen().bounds.size.height

let NAVI_HEIGHT:CGFloat = 44
let TABBAR_HEIGHT:CGFloat = 49
let STATE_BAR_HEIGHT:CGFloat = 20
let PHONE_STATE_BAR_HEIGHT:CGFloat = 40//状态栏20+占用navi20

//获取当前时区的时间
let CURRENT_DATE_TIME:String = {
  
  let date:NSDate = NSDate.init()
  let df = NSDateFormatter.init()
  df.dateFormat = "yyyy-MM-dd HH:mm:ss"
  let timeZone:NSTimeZone = NSTimeZone.localTimeZone();
  df.timeZone = timeZone;
  
  let timeString:String = df.stringFromDate(date)
  return timeString
}()
