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