//
//  MD_OC_UIView_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/27.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_OC_UIView_ViewController.h"
@interface MD_OC_UIView_ViewController()

@end

@implementation MD_OC_UIView_ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)uiviewTest
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    view2.backgroundColor = [UIColor greenColor];
    
#pragma mark 属性
    view.contentMode = UIViewContentModeBottom;//绘制模式，包含缩放、居中、内容模式（调用drewRect）等
    view.opaque = YES;//不透明，默认为YES，这样绘图系统就可以优化一些绘制操作以提升性能
    view.autoresizingMask = UIViewAutoresizingNone;//自适应匹配
    view.autoresizesSubviews = YES;//子视图是否自动适应父类的尺寸变化，默认为YES
    view.clipsToBounds = YES;//When YES, content and subviews are clipped to the bounds of the view. Default is NO.
    
#pragma mark 方法
    [self.view bringSubviewToFront:view];
    [self.view sendSubviewToBack:view];
    
    //在指定时间内执行代码块，而不是瞬间完成，达到动画效果
    [UIView animateWithDuration:.3 animations:^{
        [view2 setBackgroundColor:[UIColor orangeColor]];
    }];
}

@end
