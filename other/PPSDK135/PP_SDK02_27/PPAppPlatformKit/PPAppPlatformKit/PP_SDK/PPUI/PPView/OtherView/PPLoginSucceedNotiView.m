//
//  PPLoginSucceedNotiView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-17.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPLoginSucceedNotiView.h"
#import "PPUIKit.h"

#import "PPAppPlatformKit.h"
#import "PPCommon.h"

@implementation PPLoginSucceedNotiView

static PPLoginSucceedNotiView *ppLoginSucceedNotiView = nil;


- (id)init
{
    self = [super init];
    if (self) {
        
//        UIEdgeInsets ed = {10, 10, 10, 10};
//        [self setImage:[[PPUIKit setLocaImage:@"LoginSucceedNotificationBG"] resizableImageWithCapInsets:ed]];
        [self setBackgroundColor:[PPCommon getColor:@"202020"]];
        [self setAlpha:0.8];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
        ppLogoImageView = [[UIImageView alloc] init];
        [ppLogoImageView setImage:[PPUIKit setLocaImage:@"PPLogo"]];
        [self addSubview:ppLogoImageView];
        [ppLogoImageView setFrame:CGRectMake(20, 0, 50, 50)];
        [ppLogoImageView release];


                
        
        [self initHiddenVerticalFrame];
        userNameLabel = [[UILabel alloc] init];
        [userNameLabel setText:[NSString stringWithFormat:@"欢迎归来，%@",[[PPAppPlatformKit sharedInstance] currentShowUserName]]];
        UIFont *titleLabelFont = [UIFont fontWithName:@"Helvetica" size:24.0];
        CGSize titleSize = [userNameLabel.text sizeWithFont:titleLabelFont constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        [userNameLabel setFrame:CGRectMake(100, 4, titleSize.width, titleSize.height)];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:userNameLabel];
        [userNameLabel release];

        
    }
    return self;
}


+ (PPLoginSucceedNotiView *)sharedInstance
{
    if (!ppLoginSucceedNotiView) {
        ppLoginSucceedNotiView = [[PPLoginSucceedNotiView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] addSubview:ppLoginSucceedNotiView];
        [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:ppLoginSucceedNotiView];
        [ppLoginSucceedNotiView release];
    }
    return ppLoginSucceedNotiView;
}


#pragma mark - 设备旋转 调整视图的位置和尺寸 -

-(void)initShowVerticalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
//        [self setFrame:CGRectMake(20, 10, UI_SCREEN_WIDTH - 20 * 2, 44)];
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 50)];
    }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 50, UI_SCREEN_WIDTH, 50)];
    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - userNameLabel.frame.size.width / 2 + 40 , 12,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}



-(void)initShowHorizontalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        [self setFrame:CGRectMake(10, 40, 44, UI_SCREEN_HEIGHT - 40 * 2)];
        [self setFrame:CGRectMake(0, 0, 50, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
//        [self setFrame:CGRectMake(UI_SCREEN_WIDTH - 44 - 10, 40 , 44, UI_SCREEN_HEIGHT - 40 * 2)];
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH - 50, 0 , 50, UI_SCREEN_HEIGHT)];
    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_HEIGHT / 2 - userNameLabel.frame.size.width / 2 + 40, 12,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}

-(void)initHiddenVerticalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
//        [self setFrame:CGRectMake(20, - 44 , UI_SCREEN_WIDTH - 20 * 2, 44)];
        [self setFrame:CGRectMake(0, - 50 , UI_SCREEN_WIDTH, 50)];

    }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        [self setFrame:CGRectMake(20, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH - 20 * 2, 44)];
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 50)];

    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - userNameLabel.frame.size.width / 2 + 40, 7,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}



-(void)initHiddenHorizontalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    //iPhone处理部分
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        [self setFrame:CGRectMake(- 44, 40, 44, UI_SCREEN_HEIGHT - 40 * 2)];
        [self setFrame:CGRectMake(- 50, 0, 50, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
//        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 40 , 44, UI_SCREEN_HEIGHT - 40 * 2)];
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 0 , 50, UI_SCREEN_HEIGHT)];
    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_HEIGHT / 2 - userNameLabel.frame.size.width / 2 + 40, 7,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}



-(void)onDeviceOrientationChange:(BOOL)paramAnimated {
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    NSString *animationsStr = [NSString stringWithFormat:@"%@OnDeviceOrientationChange",
                               NSStringFromClass([self class])];
    paramAnimated = isShow;
    if (paramAnimated) {
        [UIView beginAnimations:animationsStr context:@""];
        [UIView setAnimationDuration:0.5];
    }

    if(interfaceOrientation == UIDeviceOrientationPortrait)
    {
        if ([PPUIKit getIsDeviceOrientationPortrait]) {
            [self setTransform:CGAffineTransformMakeRotation(0)];
            if (isShow) {
                [self initShowVerticalFrame];
            }else{
                [self initHiddenVerticalFrame];
            }

        }
    }
    else if(interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if ([PPUIKit getIsDeviceOrientationPortraitUpsideDown]) {
            [self setTransform:CGAffineTransformMakeRotation(M_PI)];
            if (isShow) {
                [self initShowVerticalFrame];
            }else{
                [self initHiddenVerticalFrame];
            }
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeLeft]) {
            [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
            if (isShow) {
                [self initShowHorizontalFrame];
            }else{
                [self initHiddenHorizontalFrame];
            }
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeRight]) {
            [self setTransform:CGAffineTransformMakeRotation(- M_PI_2)];
            if (isShow) {
                [self initShowHorizontalFrame];
            }else{
                [self initHiddenHorizontalFrame];
            }
        }
    }
    
    if (paramAnimated) {
        [UIView commitAnimations];
    }
}


#pragma mark  - 视图显示，隐藏，消失 -
-(void)didHiddenView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [self removeFromSuperview];
    ppLoginSucceedNotiView = nil;
    
}

-(void)didShowView
{
    [self performSelector:@selector(hiddenNotiView) withObject:nil afterDelay:3];
}

-(void)showNotiView
{
    
    [self onDeviceOrientationChange:NO];
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    [UIView beginAnimations:@"showView" context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [self initHiddenVerticalFrame];
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        [self initHiddenHorizontalFrame];
    }
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.5];
    }
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self initShowHorizontalFrame];
    }else if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        [self initShowVerticalFrame];
    }
    
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

}

-(void)hiddenNotiView
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    [UIView beginAnimations:@"hiddenView" context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];

    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self initShowHorizontalFrame];
    }else if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        [self initShowVerticalFrame];
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.5];
    }
  
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self initHiddenHorizontalFrame];
    }else if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        [self initHiddenVerticalFrame];
    }
    

    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}


#pragma mark  - 隐藏视图，显示视图 动画完成 回电函数 -

- (void)animationFinished:(NSString *)paramAnimationID finished:(BOOL)paramFinished context:(void*)paramContext
{

    if (paramFinished) {
        if ([paramAnimationID isEqualToString:@"hiddenView"]) {
            isShow = NO;
            [self didHiddenView];
        }else if ([paramAnimationID isEqualToString:@"showView"]) {
            isShow = YES;
            [self didShowView];
        }
    }
}


@end
