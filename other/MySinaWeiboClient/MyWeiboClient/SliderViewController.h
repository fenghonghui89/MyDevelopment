//
//  SliderViewController.h
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController

@property(nonatomic,retain)UIViewController *MainVC;
@property(nonatomic,retain)UIViewController *LeftVC;
@property(nonatomic,retain)UIViewController *RightVC;

//拖动后允许显示的宽度
@property(nonatomic,assign)float LeftSContentOffset;
@property(nonatomic,assign)float RightSContentOffset;

//打开和关闭的时间
@property(nonatomic,assign)float LeftSOpenDuration;
@property(nonatomic,assign)float RightSOpenDuration;
@property(nonatomic,assign)float LeftSCloseDuration;
@property(nonatomic,assign)float RightSCloseDuration;

//缩放比例
@property(nonatomic,assign)float LeftSContentScale;
@property(nonatomic,assign)float RightSContentScale;

//拖动结束时，判定最终变换效果用的x坐标
@property(nonatomic,assign)float LeftSJudgeOffset;
@property(nonatomic,assign)float RightSJudgeOffset;

+(SliderViewController *)sharedSliderController;
- (void)showLeftViewController;
- (void)showRightViewController;
@end
