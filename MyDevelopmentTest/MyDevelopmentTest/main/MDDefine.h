//
//  MDDefine.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/6/9.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#ifndef MyDevelopmentTest_MDDefine_h
#define MyDevelopmentTest_MDDefine_h


#pragma mark - 坐标 常用数值
#define screenBounds [[UIScreen mainScreen] bounds]
#define screenW [MDTool screenWidth]
#define screenH [MDTool screenHeight]
#define defaultViewW [MDTool viewControllerViewWidth]
#define defaultViewH [MDTool viewControllerViewHeight]

#define viewBounds self.view.bounds
#define viewX self.view.frame.origin.x
#define viewY self.view.frame.origin.y
#define viewW self.view.frame.size.width
#define viewH self.view.frame.size.height

#define naviH [MDTool navigationBarHeight]
#define stateH [MDTool stateBarHeight]
#define toolBarH 44
#define tarBarH 49
#define phoneStateH 40 //状态栏20+占用navi20

#pragma mark - log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define DRLog(fmt,...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#pragma mark - 字符串
#define FIRST_GET_INFO @"FIRST_GET_INFO"
#define HEADER_VIEW_PRESS @"HEADER_VIEW_PRESS"
#define FOOTER_VIEW_PRESS @"FOOTER_VIEW_PRESS"
#define DELEGATE_INFO_KEY @"DELEGATE_INFO_KEY"

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

#pragma mark - 对象
#define DGC_KEY_WINDOW [[UIApplication sharedApplication] keyWindow]


#endif