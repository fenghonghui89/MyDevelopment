//
//  MDDefine.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/6/9.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//


#ifndef MyDevelopmentTest_MDQuickDevelopDefine_h
#define MyDevelopmentTest_MDQuickDevelopDefine_h



//< 快捷属性 >
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



//< log >

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


#define ULog(format,...) do{   \
                              if ([MDGlobalManager sharedInstance].openLog) {NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);} \
                              }while(0)



//< 坐标系 >
#pragma mark - < 坐标系 >
#define screenBounds [[UIScreen mainScreen] bounds]
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height

#define viewBounds self.view.bounds
#define viewX self.view.frame.origin.x
#define viewY self.view.frame.origin.y
#define viewW self.view.frame.size.width
#define viewH self.view.frame.size.height

#define naviH 44
#define stateH 20
#define toolBarH 44
#define tabBarH 49
#define phoneStateH 40 //通话状态下状态栏高度=状态栏20+占用navi20




//< other >
#pragma mark - < other >

//keyWindow
#define MD_KEY_WINDOW [[UIApplication sharedApplication] keyWindow]

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




#endif
