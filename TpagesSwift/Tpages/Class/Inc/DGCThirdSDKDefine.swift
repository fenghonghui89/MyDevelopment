//
//  DGCThirdSDKDefine.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/6.
//  Copyright © 2016年 DGC. All rights reserved.
//第三方sdk

import Foundation

//MARK:- < 第三方sdk >
//MARK:友盟
let UMENG_APPKEY:String = "53ec86c7fd98c5cf630065c6"

//MARK:新浪微博
let UMENG_WEIBO_APPKEY:String = ""
let UMENG_WEIBO_SECRET:String = ""
let UMENG_WEIBO_URL:String = ""


//MARK:qq
let UMENG_QQ_APPID:String = ""
let UMENG_QQ_APPKEY:String = ""
let UMENG_QQ_URL:String = ""

//MARK:微信
#if DEBUG
let UMENG_WECHAT_APPID:String = "wx907b2964e73e9bb5"
let UMENG_WECHAT_APPSECRET:String = "4462d23e308d86eca2bdde345999c9ee"
let UMENG_WECHAT_URL:String = "http://tpages.cn"
  
#else
let UMENG_WECHAT_APPID:String = "wxa9cec0d7b7d9d1f1"
let UMENG_WECHAT_APPSECRET:String = "b2878be2a0922637868ff90f47351517"
let UMENG_WECHAT_URL:String = "http://tpages.cn"
#endif

//支付宝跳转用url scheme
let ALIPAY_URL_SCHEME:String = "ALIPAY_URL_SCHEME_TPAGES"
