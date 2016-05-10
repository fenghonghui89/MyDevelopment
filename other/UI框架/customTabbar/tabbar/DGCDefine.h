//
//  DGCDefine.h
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#ifndef DGCDefine_h
#define DGCDefine_h

#pragma mark - Manager 使用的宏
#define DGC_FULLURL_INFO_KEY @"fullurl"
#define HTTP_REQUEST    1
#define JSON_REQUEST    2
#define BINARY_REQUEST  3

#define SORT_DEFAULT    0
#define SORT_TEXT       1

#define LOGIN_USERNAME  1
#define LOGIN_EMAIL     2
#define LOGIN_MOBILE    3
#define LOGIN_NAME      4
#define LOGIN_MD5       (1 << 16)

#pragma mark - 一般字符串
#define firstGetInfo @"firstGetInfo"
#define headerViewPress @"headerViewPress"
#define footerViewPress @"footerViewPress"
#define delegateInfoKey @"delegateInfoKey"
#define NO_DATA_IMG @"noDataImg.png"

#pragma mark - log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define DRLog(fmt,...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#pragma mark - 快捷属性
#define  PROPERTY_NON_ATOMIC_WEAK       @property (nonatomic,weak)
#define  PROPERTY_NON_ATOMIC_ASSIGN     @property (nonatomic,assign)
#define  PROPERTY_NON_ATOMIC_COPY       @property (nonatomic,copy  )
#define  PROPERTY_NON_ATOMIC_STRONG     @property (nonatomic,strong)
#define  PROPERTY_NON_ATOMIC_READONLY   @property (nonatomic,readonly)

#define  PROPERTY_ATOMIC_ASSIGN         @property (atomic,assign  )
#define  PROPERTY_ATOMIC_COPY           @property (atomic,copy  )
#define  PROPERTY_ATOMIC_STRONG         @property (atomic,strong)
#define  PROPERTY_ATOMIC_READONLY       @property (atomic,readonly)

#pragma mark - 编码、枚举


#pragma mark - 对象
#define DGC_KEY_WINDOW [[UIApplication sharedApplication] keyWindow]

#pragma mark - url / key / id

//base
#ifdef FinallyEdition
#define baseURLbyEdition @"http://tpages.cn"
#else
#define baseURLbyEdition @"http://dev.123go.net.cn"
#endif

//pay url
#ifdef FinallyEdition
#define PAY_PAGE_URL @"http://mall.tpages.cn"
#else
#define PAY_PAGE_URL @"http://mall.dev.123go.net.cn"
#endif


//友盟
#define UMENG_APPKEY @"53ec86c7fd98c5cf630065c6"
//#define UMENG_APPKEY @"57034224e0f55a36e300126c"
////com.BiliPush.test

//微博
#define UMENG_WEIBO_APPKEY @"3309468239"
#define UMENG_WEIBO_SECRET @"3a21eec0820508abc92ecedee90f381a"
#define UMENG_WEIBO_URL @"http://tpages.cn/wbcb"

//qq
#define UMENG_QQ_APPID @"1105220570"
#define UMENG_QQ_APPKEY @"Q8W9L5bJT8TFVJkc"
#define UMENG_QQ_URL @"http://tpages.cn/qqcb"

//微信
#ifdef FinallyEdition
#define UMENG_WECHAT_APPID @"wx907b2964e73e9bb5"
#define UMENG_WECHAT_APPSECRET @"4462d23e308d86eca2bdde345999c9ee"
#else
#define UMENG_WECHAT_APPID @"wxa9cec0d7b7d9d1f1"
#define UMENG_WECHAT_APPSECRET @"b2878be2a0922637868ff90f47351517"
#endif
#define UMENG_WECHAT_URL @"http://tpages.cn"

//支付宝跳转用urlscheme
#define URL_SCHEME @"UrlSchemeTpagesMall"

#pragma mark - 一般方法宏

//单例宏
#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)share { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

//固件版本判断
#define IOS_VERSION_OR_ABOVE(_version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= _version)? (YES):(NO))

#pragma mark - 坐标系
#define screenBounds [[UIScreen mainScreen] bounds]
#define screenW [DGCTool screenWidth]
#define screenH [DGCTool screenHeight]
#define defaultViewW [DGCTool viewControllerViewWidth]
#define defaultViewH [DGCTool viewControllerViewHeight]

#define viewBounds self.view.bounds
#define viewX self.view.frame.origin.x
#define viewY self.view.frame.origin.y
#define viewW self.view.frame.size.width
#define viewH self.view.frame.size.height

#define naviH [DGCTool navigationBarHeight]
#define stateH [DGCTool stateBarHeight]
#define toolBarH 44
#define tabBarH 49
#define phoneStateH 40 //状态栏20+占用navi20



#pragma mark - 通知
#define Noti_TakeHeaderPhotoSuccess @"Noti_TakeHeaderPhotoSuccess"//发帖成功后刷新首页



#pragma mark - 一般数值宏
#define maxCellCount 6
#define PER_PAGE5 5
#define PER_PAGE10 10
#define IMAGE_QUALITY .3
//#define cellImgHeight (screenH-tabBarH-naviH-stateH-48-146) //照片高度 拍照高度
#define cellImgHeight screenW //照片高度 拍照高度


#pragma mark - typed
//typedef void(^DGCMainViewBlock)(BOOL isSuccess);//报错？
#endif
