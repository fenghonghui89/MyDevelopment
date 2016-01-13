//
//  HFSecondView.m
//  test
//
//  Created by hanyfeng on 14-5-6.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFSecondView.h"
@interface HFSecondView()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UITextField *tf;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *btn;

@end

@implementation HFSecondView

-(id)init
{
    NSLog(@"secondView init");
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        
        UILabel *bgView = [[UILabel alloc] init];
        [bgView setText:@"测试页面"];
        [bgView setTextAlignment:NSTextAlignmentCenter];
        [bgView setTextColor:[UIColor redColor]];
        [bgView setBackgroundColor:[UIColor blueColor]];
        [self addSubview:bgView];
        self.bgView = bgView;
        
        
        [self addObserver];
        [self initVerticalFrame];
    }
    
    return self;
}

#pragma mark - 添加旋屏通知 -
-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUIFrame) name:UIApplicationDidChangeStatusBarOrientationNotification  object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUIFrame) name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - 注销广播、返回上一层页面 -
-(void)tap{
    NSLog(@"返回上一层页面");
    [[NSNotificationCenter defaultCenter] removeObserver:self];//注销广播
    [self removeFromSuperview];
}

#pragma mark - 打印信息 -
//打印信息
-(void)showInfo
{
    NSLog(@"-----%@-----",[self showInterfaceOrientation]);
    NSLog(@"frame:%@",NSStringFromCGRect(self.frame));
    NSLog(@"bound:%@",NSStringFromCGRect(self.bounds));
    NSLog(@"transform:%@",NSStringFromCGAffineTransform(self.transform));
}

//打印当前旋转方向
-(NSString *)showInterfaceOrientation{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    NSString* string = nil;
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        string = @"Portrait";
    }
    if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        string = @"PortraitUpsideDown";
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        string = @"LandscapeLeft";
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        string = @"LandscapeRight";
    }
    return string;
}

#pragma mark - 设置控件坐标 -
//改变固有控件的坐标
-(void)changeUIFrame
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    if (interfaceOrientation == UIDeviceOrientationPortrait) {
        [self showInfo];
        [self setTransform:CGAffineTransformMakeRotation(0)];
        [self initVerticalFrame];
    }
    
    if (interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        [self showInfo];
        [self setTransform:CGAffineTransformMakeRotation(M_PI)];
        [self initVerticalFrame];
    }
    
    if (interfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        [self showInfo];
        [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [self initHorizontalFrame];
    }
    
    if (interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        [self showInfo];
        [self setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
        [self initHorizontalFrame];
    }
}

//初始化竖屏坐标
-(void)initVerticalFrame
{
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [_bgView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
}

//初始化横屏坐标
-(void)initHorizontalFrame
{
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [_bgView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
}

#pragma mark - 旋屏开关 -
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
