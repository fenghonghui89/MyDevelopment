//
//  BJToolDefine
//  XTJMall
//
//  Created by hanyfeng on 2017/6/7.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef BJToolDefine_h
#define BJToolDefine_h



// < 快捷属性 >
#pragma mark - < 快捷属性 >
#define  PROPERTY_NON_ATOMIC_WEAK       @property (nonatomic,weak)
#define  PROPERTY_NON_ATOMIC_ASSIGN     @property (nonatomic,assign)
#define  PROPERTY_NON_ATOMIC_COPY       @property (nonatomic,copy  )
#define  PROPERTY_NON_ATOMIC_STRONG     @property (nonatomic,strong)
#define  PROPERTY_NON_ATOMIC_READONLY   @property (nonatomic,readonly)

#define  PROPERTY_ATOMIC_ASSIGN         @property (atomic,assign  )
#define  PROPERTY_ATOMIC_COPY           @property (atomic,copy  )
#define  PROPERTY_ATOMIC_STRONG         @property (atomic,strong)
#define  PROPERTY_ATOMIC_READONLY       @property (atomic,readonly)


// < block weak / strong >
#pragma mark - < block weak / strong >
#define XTJBlockWeak(type) __weak typeof(type) weak##_##type = type
#define XTJBlockStrong(type) __strong typeof(type) strong##_##type = weak##_##type


// < 日志输出 >

#pragma mark - < log >

#ifdef DEBUG
#define DLog(format, ...) do{    \
NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);    \
}while(0)
#else
#define DLog(...)
#endif


#define DRLog(format,...) do{    \
NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);    \
}while(0)


#ifdef BJOpenLogFlag
#define ULog(format,...) do{   \
NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \
}while(0)
#else
#define ULog(format,...)
#endif

//INFO级别
#define HZLogInfo(format, ...) DDLogInfo((@"[%@][Line:%d]:" format), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__)
//Error级别
#define HZLogError(format, ...) DDLogError((@"[%@][Line:%d]:" format), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__)


// < 数学函数 >
#pragma mark - < 数学函数 >
#define AngleToRadian(angle) ((angle) * M_PI / 180.0)



// < 坐标系 尺寸 >
#pragma mark - < 坐标系 >
#define BJ_SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height

#define viewBounds self.view.bounds
#define viewX self.view.frame.origin.x
#define viewY self.view.frame.origin.y
#define viewW self.view.frame.size.width
#define viewH self.view.frame.size.height

#define naviH 44.00
#define stateH UIView.statusBarFrame.size.height//UIView+XTJ 非通话状态:x-44 非x-20;通话状态下:x-44 非x-40
#define toolBarH 44.00
#define tabBarH ([UIDevice isiPhoneXSeries]?83.00:49.00)
#define phoneStateH [[UIApplication sharedApplication] statusBarFrame].size.height+20.00 //通话状态下状态栏高度=状态栏高度+占用navi20

#define screenW_375 375.00
#define screenH_375 667.00
#define screenW_iphonePlus 414.00
#define screenH_iphonePlus 736.00
#define screenW_ipad97 768.00
#define screenH_ipad97 1024.00
#define BJ_ScaleW  screenW/screenW_375
#define BJ_ScaleH  screenH/screenH_375
// < other >
#pragma mark - < other >





//keyWindow
#define XTJ_KEY_WINDOW [[UIApplication sharedApplication] keyWindow]

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

//运行时判断设备系统版本
#define IOS_VERSION_OR_ABOVE(_version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= _version)? (YES):(NO))

//判断设备是否是iPad
#define iPadDevice (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//多线程安全
#define dispatch_main_sync_safe_xtj(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe_xtj(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//UIColor
#define XTJColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define XTJColorFromRGB(rgbValue) XTJColorFromRGBA(rgbValue, 1.0)

#endif /* BJToolDefine_h */
