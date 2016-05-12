//
//  MD_OC_UIView_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/27.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_OC_UIView_ViewController.h"
#import "MDCustomView.h"
@interface MD_OC_UIView_ViewController()
@property (strong, nonatomic)  UILabel *label1;
@property (strong, nonatomic)  UILabel *label2;
@end

@implementation MD_OC_UIView_ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self uiviewTest5];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self uiviewTest4];
}

#pragma mark 属性
-(void)uiviewTest0
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    view.contentMode = UIViewContentModeBottom;//绘制模式，包含缩放、居中、内容模式（调用drewRect）等
    view.opaque = YES;//不透明，默认为YES，这样绘图系统就可以优化一些绘制操作以提升性能
    view.autoresizingMask = UIViewAutoresizingNone;//自适应匹配
    view.autoresizesSubviews = YES;//子视图是否自动适应父类的尺寸变化，默认为YES
    view.clipsToBounds = YES;//超出显示范围的内容不显示
    view.tintColor = [UIColor greenColor];//如果设置window的tintColor，会影响整个程序所有view的tintColor，除非某view特别设置
}

#pragma mark bringSubviewToFront / sendSubviewToBack
-(void)uiviewTest1
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    [self.view bringSubviewToFront:view2];
    [self.view sendSubviewToBack:view];
}

#pragma mark index / 交换层级
-(void)uiviewTest4
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    NSLog(@"1 start---%d",[[self.view subviews] indexOfObject:view]);
    NSLog(@"2 start---%d",[[self.view subviews] indexOfObject:view2]);
    
    [self.view exchangeSubviewAtIndex:[[self.view subviews] indexOfObject:view]
                   withSubviewAtIndex:[[self.view subviews] indexOfObject:view2]];
    
    NSLog(@"1 now---%d",[[self.view subviews] indexOfObject:view]);
    NSLog(@"2 now---%d",[[self.view subviews] indexOfObject:view2]);
}

#pragma mark appearance
-(void)uiviewTest2
{
    UIImage * image = [UIImage imageNamed:@"delete_btn.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    
    //批量修改该类及其子类下所有对象的属性
    [[UIButton appearance] setBackgroundImage:image forState:UIControlStateNormal];
}

#pragma mark UIView动画
-(void)uiviewTest3
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BurstAircraftAircraftBig.png"]];
    iv.frame = CGRectMake((viewW-70)*0.5, viewH-50-10-89, 70, 89);
    [self.view addSubview:iv];
    
    //简化版
//    [UIView animateWithDuration:2 animations:^{
//        [iv setFrame:CGRectMake(200, 100, 100, 100)];
//        iv.alpha = 1;
//    }];
    
    //完整版
//    [UIView animateWithDuration:2
//                          delay:0//延迟多久在执行动画
//                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut//效果选项(补间曲线，可以同时用多种)
//                     animations:^{
//                         [iv setFrame:CGRectMake(200, 100, 100, 100)];
//                         iv.alpha = 1;
//                     }
//                     completion:^(BOOL finished) {
//                         [iv setBackgroundColor:[UIColor greenColor]];
//                     }];
    
    //递归动画
    [self spinAnimationOnView:iv duration:4 clockwise:YES];
}

-(void)spinAnimationOnView:(UIView *)view
                    duration:(NSTimeInterval)duration
                   clockwise:(BOOL)clockwise
{
    [UIView animateWithDuration:duration / 4.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear//匀速
                     animations:^{
         view.transform = CGAffineTransformRotate(view.transform, M_PI_4 * (clockwise ? 1 : -1));
     }
                     completion:^(BOOL finished) {
         [self spinAnimationOnView:view duration:duration clockwise:clockwise];
     }];
}

#pragma mark UIView动画早期版本
-(void)uiviewTest5
{
    UILabel *label1      = [[UILabel alloc] initWithFrame:CGRectMake(20, 237, 107, 21)];
    [label1 setBackgroundColor:[UIColor greenColor]];
    label1.text          = @"label1";
    [self.view addSubview:label1];
    _label1 = label1;
    
    UILabel *label2      = [[UILabel alloc] initWithFrame:CGRectMake(184, 237, 107, 21)];
    [label2 setBackgroundColor:[UIColor redColor]];
    label2.text          = @"label2";
    [self.view addSubview:label2];
    _label2 = label2;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((viewW-50)*0.5, viewH - 50, 50,50)];
    [btn setTitle:@"改变" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    btn.showsTouchWhenHighlighted = YES;
    [btn addTarget:self action:@selector(tap5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)tap5
{
    CGRect frame1 = self.label1.frame;
    CGRect frame2 = self.label2.frame;

    [UIView beginAnimations:@"add" context:nil];//开始动画
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2];//动画持续时间
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];//动画速度曲线
//    [UIView setAnimationWillStartSelector:@selector(startAnimation:)];//动画开始前执行方法
    [UIView setAnimationDidStopSelector:@selector(endAnimation:)];//动画结束后执行方法
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];//动画过渡方式
    
    [self.label1 setFrame:frame2];
    [self.label2 setFrame:frame1];
    
    [UIView commitAnimations];//结束动画
}

-(void)startAnimation:(NSString *)animationID
{
    if ([animationID isEqualToString:@"add"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageNamed:@"icon.jpg"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *iv = [[UIImageView alloc] initWithImage:image];
                [iv setFrame:CGRectMake(150, 400, 50, 50)];
                [self.view addSubview:iv];
            });
        });
        NSLog(@"add start");
    }else{
        NSLog(@"not start");
    }
}

-(void)endAnimation:(NSString *)animationID
{
    if ([animationID isEqualToString:@"add"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageNamed:@"icon.jpg"];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *iv = [[UIImageView alloc] initWithImage:image];
                [iv setFrame:CGRectMake(150, 300, 50, 50)];
                [self.view addSubview:iv];
            });
        });
        NSLog(@"add end");
    }else{
        NSLog(@"not end");
    }

}
@end
