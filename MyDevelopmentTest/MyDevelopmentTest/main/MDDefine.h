//
//  MDDefine.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/6/9.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#ifndef MyDevelopmentTest_MDDefine_h
#define MyDevelopmentTest_MDDefine_h
#endif

#define screenBounds [[UIScreen mainScreen] bounds]
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height

#define viewBounds self.view.bounds
#define viewX self.view.frame.origin.x
#define viewY self.view.frame.origin.y
#define viewW self.view.bounds.size.width
#define viewH self.view.bounds.size.height

#define naviH [MDTool navigationBarHeight]
#define stateH 20
#define toolBarH 44
#define tarBarH 49
#define phoneStateH 40 //状态栏20+占用navi20