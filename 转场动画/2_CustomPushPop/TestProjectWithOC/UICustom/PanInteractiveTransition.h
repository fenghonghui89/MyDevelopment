//
//  PanInteractiveTransition.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/22.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//手势返回 可能会没有回弹动效 只要达到临界值 并且手指离开屏幕 vc状态会切换为finish 动效会直接过渡到最后状态

#import <UIKit/UIKit.h>

@interface PanInteractiveTransition : UIPercentDrivenInteractiveTransition
-(void)panToPop:(UIViewController *)viewcontroller;
@property(nonatomic,assign)BOOL interacting;//供vc判断要返回nil还是对象
@end

