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
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *backButton;

@end

@implementation HFSecondView

-(id)init
{
    NSLog(@"secondView init");
    self = [super init];
    
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        
        UIView *bgView = [[UIView alloc] init];
        [bgView setBackgroundColor:[UIColor blueColor]];
        [self addSubview:bgView];
        self.bgView = bgView;
        
        UILabel *label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor redColor]];
        [label setText:@"测试页面"];
        [label setTextColor:[UIColor greenColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.bgView addSubview:label];
        self.label = label;
        
        UIButton *backButton = [[UIButton alloc] init];
        [backButton setBackgroundColor:[UIColor redColor]];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:backButton];
        self.backButton = backButton;
        
        //添加旋屏通知后要手动调用一次旋屏触发事件，否则页面刚出现时不会坐标不会调整
        [self addObserver];
        [self OrientationDidChange];
    }
    
    return self;
}

-(void)back
{
    [self hiddenViewInRight];
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
    if (interfaceOrientation == UIDeviceOrientationPortrait) {
        string = @"Portrait";
    }
    if (interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        string = @"PortraitUpsideDown";
    }
    if (interfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        string = @"LandscapeLeft";
    }
    if (interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        string = @"LandscapeRight";
    }
    return string;
}

#pragma mark - 设置控件坐标 -
//旋转通知响应事件
-(void)OrientationDidChange
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

//调整竖屏坐标
-(void)initVerticalFrame
{
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.bgView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.label setFrame:CGRectMake(self.bgView.bounds.size.width - (self.bgView.bounds.size.width - 100) / 2 - 100, 50, 100, 30)];
    [self.backButton setFrame:CGRectMake(self.bgView.bounds.size.width - (self.bgView.bounds.size.width - 100) / 2 - 100, 90, 100, 30)];
}

//调整横屏坐标
-(void)initHorizontalFrame
{
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.bgView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
    
    [self.label setFrame:CGRectMake(self.bgView.bounds.size.width - (self.bgView.bounds.size.width - 100) / 2 - 100, 50, 100, 30)];
    [self.backButton setFrame:CGRectMake(self.bgView.bounds.size.width - (self.bgView.bounds.size.width - 100) / 2 - 100, 90, 100, 30)];
}

#pragma mark - 动画出现、动画消失 -
//从右边出现
-(void)showViewInRight
{
    //判断程序的方向，设定起点坐标为屏幕之外
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait){
        [self setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(-[[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, -[[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }
    
    //开始动画，传递参数showView到下面的选择器中
    [UIView beginAnimations:@"showViewInRight" context:nil];
    //动画结束后执行
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    
    //判断设备是ipad还是iphone，设定动画时间
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.4];
    }
    
    //终点坐标
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

//从右边消失
-(void)hiddenViewInRight
{
    //开始动画，传递参数showView到下面的选择器中
    [UIView beginAnimations:@"hiddenViewInRight" context:nil];
    //动画结束后执行
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    
    //判断设备是ipad还是iphone，设定动画时间
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.4];
    }
    
    //按照屏幕方向设定终点坐标
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait){
        [self setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(-[[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, -[[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

-(void)animationFinished:(NSString *)parmar
{
    NSLog(@"animationFinished:%@",parmar);
    
    if ([parmar isEqualToString:@"hiddenViewInRight"]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        [self removeFromSuperview];
    }
}

#pragma mark - 旋屏开关、旋屏通知 -
-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange) name:UIApplicationDidChangeStatusBarOrientationNotification  object:nil];
}

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
