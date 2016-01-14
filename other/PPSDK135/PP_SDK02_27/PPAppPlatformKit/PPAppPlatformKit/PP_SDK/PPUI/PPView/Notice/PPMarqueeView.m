//
//  PPMarqueeView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-13.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPMarqueeView.h"
#import "PPCommon.h"

static PPMarqueeView * ppMarqueeView = nil;


@implementation PPMarqueeView

+ (PPMarqueeView *)sharedInstance
{
    if (!ppMarqueeView) {
        ppMarqueeView = [[PPMarqueeView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppMarqueeView atIndex:2220];
        [ppMarqueeView release];
    }
    return ppMarqueeView;
}

- (id)init
{
    self = [super init];
    if (self) {

        [self setBackgroundColor:[PPCommon getColor:@"202020"]];
        [self setAlpha:0.8];
        _isShow = NO;
        [self setClipsToBounds:YES];

        
        _subLabel = [[UILabel alloc] init];
        [_subLabel setFont:[UIFont systemFontOfSize:15]];
        [_subLabel setTextColor:[UIColor whiteColor]];
        [_subLabel setBackgroundColor:[UIColor clearColor]];
        
      
        [self addSubview:_subLabel];

        [_subLabel release];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    
    return self;
}

- (void) setText : (NSString *)text
{
  
    [_subLabel setText:text];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(9999, 20) lineBreakMode:NSLineBreakByWordWrapping];

     UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {

        [_subLabel setFrame:CGRectMake(self.frame.size.height, 0, labelSize.width, 20)];
    }
    else
    {
        [_subLabel setFrame:CGRectMake(self.frame.size.width, 0, labelSize.width, 20)];
    }
    [_subLabel setHidden:YES];
}

- (void)marqueeBeginScroll
{
    float width = _subLabel.frame.size.width;
    
    _isShow = YES;
    float time = (width + self.frame.size.width) / 50;
    [_subLabel setHidden:NO];
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {

        time = (width + self.frame.size.height) / 50;
        [_subLabel setFrame:CGRectMake(self.frame.size.height, 0, _subLabel.frame.size.width, 20)];
        
    }
    else
    {
        [_subLabel setFrame:CGRectMake(self.frame.size.width, 0, _subLabel.frame.size.width, 20)];
    }
    
    [UIView animateWithDuration:time
                     animations:^{
                         [_subLabel setFrame:CGRectMake(-width, 0, width, 20)];
                     }
                     completion:^(BOOL completed){

                         [self hiddenMarqueeView];
                     }];
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

-(void)showMarqueeView
{
    [self onDeviceOrientationChange:NO];
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];

    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [self initHiddenVerticalFrame];
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        [self initHiddenHorizontalFrame];
    }
    float time = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        time = 0.8;
    }else{
        time = 0.5;
    }
    
    [UIView animateWithDuration:time
                     animations:^{
                         if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
                             [self initShowHorizontalFrame];
                         }else if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
                             [self initShowVerticalFrame];
                         }
    }
                     completion:^(BOOL completed){
                         [self marqueeBeginScroll];
        
    }];
    
}


-(void)hiddenMarqueeView
{
    if(!_isShow)
    {
        [self didHiddenView];
    }
    else
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
    
}



-(void)initShowVerticalFrame{
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 20)];
    }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 20, UI_SCREEN_WIDTH, 20)];
    }
}


-(void)initShowHorizontalFrame{
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, 0, 20, UI_SCREEN_HEIGHT)];
        
        
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH - 20, 0 , 20, UI_SCREEN_HEIGHT)];
//        [_subLabel setFrame:CGRectMake(0, 0, _subLabel.frame.size.width, 20)];
    }
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
}



-(void)onDeviceOrientationChange:(BOOL)paramAnimated {
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    NSString *animationsStr = [NSString stringWithFormat:@"%@OnDeviceOrientationChange",
                               NSStringFromClass([self class])];
    paramAnimated = _isShow;
    if (paramAnimated) {
        [UIView beginAnimations:animationsStr context:@""];
        [UIView setAnimationDuration:0.5];
    }
    
    if(interfaceOrientation == UIDeviceOrientationPortrait)
    {
        if ([PPUIKit getIsDeviceOrientationPortrait]) {
            [self setTransform:CGAffineTransformMakeRotation(0)];
            if (_isShow) {
                
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
            if (_isShow) {
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
            if (_isShow) {
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
            if (_isShow) {
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


#pragma mark  - 隐藏视图，显示视图 动画完成 回电函数 -

- (void)animationFinished:(NSString *)paramAnimationID
                 finished:(BOOL)paramFinished
                  context:(void*)paramContext
{
    
    if (paramFinished) {
        if ([paramAnimationID isEqualToString:@"hiddenView"]) {
            _isShow = NO;
            [self didHiddenView];
        }else if ([paramAnimationID isEqualToString:@"showView"]) {
            _isShow = YES;
            [self didShowView];
        }
    }
}



-(void)didHiddenView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    [self removeFromSuperview];
    ppMarqueeView = nil;
    
}

-(void)didShowView
{
//    [self performSelector:@selector(hiddenNotiView) withObject:nil afterDelay:3];
}


@end
