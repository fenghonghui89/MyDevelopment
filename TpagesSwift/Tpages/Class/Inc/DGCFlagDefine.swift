//
//  DGCFlagDefine.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/6.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

//MARK:- < url >
//MARK:tpages
#if DEBUG
let URL_TPAGES:String = "http://dev.123go.net.cn"
#else
let URL_TPAGES:String = "http://tpages.cn"
#endif

//MARK:tpages mall url
#if DEBUG
let URL_TPAGES_MALL:String = "http://mall.dev.123go.net.cn"
#else
let URL_TPAGES_MALL:String = "http://mall.tpages.cn"
#endif

//MARK:会员中心 积分url
#if DEBUG
let URL_USER_CENTER_INTEGRAL:String = "http://dev.123go.net.cn/home.php?mod=spacecp&ac=integral"
#else
let URL_USER_CENTER_INTEGRAL:String = "http://tpages.cn/home.php?mod=spacecp&ac=integral"
#endif

//MARK:第三方登录 url
#if DEBUG
let URL_Third_Login:String = "http://dev.123go.net.cn/plugin.php?id=portalogin:login&action=morelogin&json="
#else
let URL_Third_Login:String = "http://tpages.cn/plugin.php?id=portalogin:login&action=morelogin&json="
#endif

//MARK:- < url host >
//MARK:tpages
let HOST_TPAGES_CN:String = "tpages.cn"
let HOST_TPAGES_DEV:String = "dev.123go.net.cn"

#if DEBUG
let HOST_TPAGES:String = "dev.123go.net.cn"
#else
let HOST_TPAGES:String = "tpages.cn"
#endif

//MARK:mall
let HOST_MALL_CN:String = "mall.dev.123go.net.cn"
let HOST_MALL_DEV:String = "mall.tpages.cn"

#if DEBUG
let HOST_MALL = "mall.dev.123go.net.cn"
#else
let HOST_MALL = "mall.tpages.cn"
#endif


//MARK:- < 通知 >
let NOTI_TakeHeaderPhotoSuccess:String = "NOTI_TakeHeaderPhotoSuccess"//头像更新成功通知
let NOTI_NETWORK_STATE:String = "NOTI_NETWORK_STATE"//网络状态更改
let NOTI_TRANSITION_TPAGES:String = "NOTI_TRANSITION_TPAGES"//外部跳转到tpages
let NOTI_TRANSITION_MALL:String = "NOTI_TRANSITION_MALL" //外部跳转到商城
let NOTI_TRANSITION_USER_CENTER:String = "NOTI_TRANSITION_USER_CENTER" //外部跳转到个人中心
let NOTI_LOGIN_LOGOUT_SUCCESS:String = "NOTI_LOGIN_LOGOUT_SUCCESS"//登录或注销成功通知

//MARK:- < 枚举 >
enum DGCPageType:Int{
  case DGCPageTypeTpages = 0, //t视界
  DGCPageTypeMall = 1, //商城
  DGCPageTypeUserCenter = 2, //会员
  DGCPageTypeUnknow = 3, //未知
  DGCPageTypeURLError = 4, //无效url，推送容错用
  DGCPageTypeURLOpenNewPage = 5 //打开新页面
}
