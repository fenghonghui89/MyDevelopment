//
//  PPLoginSucceedNotiView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-17.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPNewMessageView.h"
#import "PPUIKit.h"

#import "PPAppPlatformKit.h"
#import "PPCommon.h"

@implementation PPNewMessageView

static PPNewMessageView *ppNewMessageView = nil;


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
        [ppLogoImageView setFrame:CGRectMake(20, 0, 20, 20)];
        [ppLogoImageView release];


                
        
        [self initHiddenVerticalFrame];
        userNameLabel = [[UILabel alloc] init];
//        [userNameLabel setText:[NSString stringWithFormat:@"您有新邮件.请注查收，%@",[[PPAppPlatformKit sharedInstance] currentShowUserName]]];
        [userNameLabel setText:@"您有新邮件.请注意查收"];
        UIFont *titleLabelFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        CGSize titleSize = [userNameLabel.text sizeWithFont:titleLabelFont constrainedToSize:CGSizeMake(MAXFLOAT, 12)];
        [userNameLabel setFrame:CGRectMake(80, 0, titleSize.width, 20)];
        [userNameLabel setFont:[UIFont systemFontOfSize:10]];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:userNameLabel];
        [userNameLabel release];

        
    }
    return self;
}


+ (PPNewMessageView *)sharedInstance
{
    if (!ppNewMessageView) {
        ppNewMessageView = [[PPNewMessageView alloc] init];
//        [[[UIApplication sharedApplication] keyWindow] addSubview:ppNewMessageView];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppNewMessageView atIndex:2220];
//        [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:ppLoginSucceedNotiView];
        [ppNewMessageView release];
    }
    return ppNewMessageView;
}

-(void)initShowVerticalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
//        [self setFrame:CGRectMake(20, 10, UI_SCREEN_WIDTH - 20 * 2, 44)];
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 20)];
    }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 20, UI_SCREEN_WIDTH, 20)];
    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - userNameLabel.frame.size.width / 2 + 20 , 0,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}



-(void)initShowHorizontalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, 0, 20, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH - 20, 0 , 20, UI_SCREEN_HEIGHT)];
    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_HEIGHT / 2 - userNameLabel.frame.size.width / 2, 0,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}

-(void)initHiddenVerticalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
//        [self setFrame:CGRectMake(20, - 44 , UI_SCREEN_WIDTH - 20 * 2, 44)];
        [self setFrame:CGRectMake(0, - 20 , UI_SCREEN_WIDTH, 20)];

    }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        [self setFrame:CGRectMake(20, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH - 20 * 2, 44)];
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 20)];

    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - userNameLabel.frame.size.width / 2 + 20, 0,
                                       userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
}



-(void)initHiddenHorizontalFrame{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    //iPhone处理部分
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        [self setFrame:CGRectMake(- 44, 40, 44, UI_SCREEN_HEIGHT - 40 * 2)];
        [self setFrame:CGRectMake(- 20, 0, 20, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
//        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 40 , 44, UI_SCREEN_HEIGHT - 40 * 2)];
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 0 , 20, UI_SCREEN_HEIGHT)];
    }
    [userNameLabel setFrame:CGRectMake(UI_SCREEN_HEIGHT / 2 - userNameLabel.frame.size.width / 2, 0,
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


#pragma mark  -------------------------Animation Delegate methods ------------------------------------
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
-(void)didHiddenView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [self removeFromSuperview];
    ppNewMessageView = nil;

}

-(void)didShowView
{
    [self performSelector:@selector(hiddenNotiView) withObject:nil afterDelay:3];
}


@end
