//
//  MDDpecialDefine.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//特定用途的宏

#ifndef MDSpecialDefine_h
#define MDSpecialDefine_h


//< 字符串常量 >
#pragma mark - < 字符串常量 >
#define FIRST_GET_INFO @"FIRST_GET_INFO"
#define HEADER_VIEW_PRESS @"HEADER_VIEW_PRESS"
#define FOOTER_VIEW_PRESS @"FOOTER_VIEW_PRESS"
#define DELEGATE_INFO_KEY @"DELEGATE_INFO_KEY"





//< 枚举 >
#pragma mark - < 枚举 >
typedef NS_ENUM(NSInteger,DGCRequestErrorCode) {
  DGCRequestErrorCodeSuccess = 102,
};

typedef NS_ENUM(NSInteger,DGCRequestCode) {
  DGCRequestCodeLogin = 1001,
  DGCRequestCodePost = 1002,
};




//< URL >
#pragma mark - < URL >

//tpages
#ifdef FinallyEdition
#define URL_TPAGES @"http://tpages.cn"
#else
#define URL_TPAGES @"http://dev.123go.net.cn"
#endif

//tpages mall url
#ifdef FinallyEdition
#define URL_TPAGES_MALL @"http://mall.tpages.cn"
#else
#define URL_TPAGES_MALL @"http://mall.dev.123go.net.cn"
#endif

//会员中心 积分url
#ifdef FinallyEdition
#define URL_USER_CENTER_INTEGRAL @"http://tpages.cn/home.php?mod=spacecp&ac=integral"
#else
#define URL_USER_CENTER_INTEGRAL @"http://dev.123go.net.cn/home.php?mod=spacecp&ac=integral"
#endif

//第三方登录 url
#ifdef FinallyEdition
#define URL_Third_Login @"http://tpages.cn/plugin.php?id=portalogin:login&action=morelogin&json="
#else
#define URL_Third_Login @"http://dev.123go.net.cn/plugin.php?id=portalogin:login&action=morelogin&json="
#endif


//url host - tpages
#define HOST_TPAGES_CN @"tpages.cn"
#define HOST_TPAGES_DEV @"dev.123go.net.cn"

#ifdef FinallyEdition
#define HOST_TPAGES @"tpages.cn"
#else
#define HOST_TPAGES @"dev.123go.net.cn"
#endif


//url host - tpages mall
#define HOST_MALL_CN @"mall.tpages.cn"
#define HOST_MALL_DEV @"mall.dev.123go.net.cn"

#ifdef FinallyEdition
#define HOST_MALL @"mall.tpages.cn"
#else
#define HOST_MALL @"mall.dev.123go.net.cn"
#endif




//< 通知 >
#pragma mark - < 通知 >
#define NOTI_TakeHeaderPhotoSuccess @"NOTI_TakeHeaderPhotoSuccess"//头像更新成功通知
#define NOTI_NETWORK_STATE @"NOTI_NETWORK_STATE"//网络状态更改
#define NOTI_TRANSITION_TPAGES @"NOTI_TRANSITION_TPAGES"//外部跳转到tpages
#define NOTI_TRANSITION_MALL @"NOTI_TRANSITION_MALL" //外部跳转到商城
#define NOTI_TRANSITION_USER_CENTER @"NOTI_TRANSITION_USER_CENTER" //外部跳转到个人中心
#define NOTI_LOGIN_LOGOUT_SUCCESS @"NOTI_LOGIN_LOGOUT_SUCCESS"//登录或注销成功通知





#endif /* MDDpecialDefine_h */
