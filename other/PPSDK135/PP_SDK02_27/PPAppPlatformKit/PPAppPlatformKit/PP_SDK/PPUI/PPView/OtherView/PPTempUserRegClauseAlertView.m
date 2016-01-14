//
//  PPTempUserRegClauseAlertView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-24.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPTempUserRegClauseAlertView.h"
#import "PPAppPlatformKit.h"
#import <QuartzCore/QuartzCore.h>

#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@implementation PPTempUserRegClauseAlertView
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self) {
        
        isAgreeClause = NO;
        
        grayView = [[UIView alloc] init];
        [grayView setBackgroundColor:[UIColor blackColor]];
        [grayView setFrame:CGRectMake(-420, -480, 320 * 4, 480 * 4)];
        [self addSubview:grayView];
        [grayView release];
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[[PPUIKit setLocaImage:@"PPUIAlertViewBG"]
                                                                          stretchableImageWithLeftCapWidth:142 topCapHeight:31]];
        [backgroundView setUserInteractionEnabled:YES];
        [backgroundView  setTag:10];
        [self addSubview:backgroundView];
        [backgroundView release];
        
        titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"PP充值平台服务使用协议"]; 
        [backgroundView addSubview:titleLabel];
        [titleLabel release];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(cancelButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor clearColor]];
        [cancelButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertCancelbutton"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
                                forState:UIControlStateNormal];
        [backgroundView addSubview:cancelButton];
        
        
        OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [OKButton setEnabled:NO];
        [OKButton addTarget:self action:@selector(OKButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        [OKButton setTitle:@"确定" forState:UIControlStateNormal];
        [OKButton setBackgroundColor:[UIColor clearColor]];
        [OKButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertOKbutton"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
                                forState:UIControlStateNormal];
        [backgroundView addSubview:OKButton];

        agreeClauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [agreeClauseButton addTarget:self action:@selector(agreeClauseButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [agreeClauseButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [backgroundView addSubview:agreeClauseButton];
        
        agreeClauseLabel = [[PPHyperlinkLabel alloc] init];
        [agreeClauseLabel setDelegate:self];
        [agreeClauseLabel setText:@"我同意以上服务条款"];
        [agreeClauseLabel setTextColor:[UIColor whiteColor]];
        [agreeClauseLabel setBackgroundColor:[UIColor clearColor]];
        [backgroundView addSubview:agreeClauseLabel];
        [agreeClauseLabel release];
        
        textClauseScrollView = [[UITextView alloc] init];
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *imagePath = [mainBundle pathForResource:[NSString stringWithFormat:@"PPImage.bundle/%@",@"b"] ofType:@"txt"];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *str = [NSString stringWithContentsOfFile:imagePath encoding:enc error:nil];
        [textClauseScrollView setText:str];
        [textClauseScrollView setEditable:NO];
        [textClauseScrollView setContentSize:CGSizeMake(250, 260)];
        [backgroundView addSubview:textClauseScrollView];
        [textClauseScrollView release];

        [self initVerticalFrame];


        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
    }
    return self;
}

-(void)initVerticalFrame{
    UIView *backgroundView = [self viewWithTag:10];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self setFrame:CGRectMake(225, 260, UI_IPHONE_SCREEN_WIDTH, UI_IPHONE_SCREEN_HEIGHT)];
        [backgroundView setFrame:CGRectMake(20, (UI_IPHONE_SCREEN_HEIGHT - 380) / 2, 280 , 380)];
    }else{
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [backgroundView setFrame:CGRectMake(20, (UI_SCREEN_HEIGHT - 380) / 2, 280 , 380)];
    }

    


    CGSize titleSize = CGSizeMake(210, 30);
    [titleLabel setFrame:CGRectMake((backgroundView.frame.size.width - titleSize.width) / 2 + 10,
                                    10, titleSize.width, titleSize.height)];
    


    [OKButton setFrame:CGRectMake(20 + 110 + 20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    [cancelButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    [agreeClauseButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20 - 44, 30, 44)];
    [agreeClauseLabel setFrame:CGRectMake(agreeClauseButton.frame.size.width + 20 + 10, backgroundView.frame.size.height - 40 - 20 - 44, 180, 44)];
    [textClauseScrollView setFrame:CGRectMake(15, titleLabel.frame.size.height + 10, 250, 240)];
 

}

-(void)initHorizontalFrame{
    UIView *backgroundView = [self viewWithTag:10];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [backgroundView setFrame:CGRectMake(20, (UI_IPHONE_SCREEN_HEIGHT - 280) / 2, 280 , 280)];
    }else{
        [backgroundView setFrame:CGRectMake(20, (UI_SCREEN_HEIGHT - 280) / 2, 280 , 280)];
    }

    [OKButton setFrame:CGRectMake(20 + 110 + 20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    [cancelButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    [agreeClauseButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20 - 44, 30, 44)];
    [agreeClauseLabel setFrame:CGRectMake(agreeClauseButton.frame.size.width + 20 + 10, backgroundView.frame.size.height - 40 - 20 - 44, 180, 44)];
    [textClauseScrollView setFrame:CGRectMake(15, titleLabel.frame.size.height + 10, 250, 140)];
}

-(void)OKButtonPressdown{
    [OKButton setTag:1];
    [delegate didClickButton:OKButton];
    [self dismissAlertView:OKButton];

}

-(void)cancelButtonPressdown{
    [cancelButton setTag:2];
    [delegate didClickButton:cancelButton];

    [self dismissAlertView:cancelButton];

}

-(void)agreeClauseButtonPressdown{
    if (isAgreeClause) {
        isAgreeClause = NO;
        [OKButton setEnabled:NO];
        [agreeClauseLabel setTextColor:[UIColor whiteColor]];
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [agreeClauseButton setImage:iamgeTmp
                           forState:UIControlStateNormal];
    }else{
        isAgreeClause = YES;
        [OKButton setEnabled:YES];
        [agreeClauseLabel setTextColor:COLOR(59,136,195,1.0)];
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox_checked"];
        [agreeClauseButton setImage:iamgeTmp
                           forState:UIControlStateNormal];
    }
}

-(int)showModel
{
    [self onDeviceOrientationChange:NO];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:self atIndex:1000];
    [grayView setAlpha:0.4];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[self viewWithTag:10].layer addAnimation:popAnimation forKey:nil];
//    CFRunLoopRun();
    return self.tag;

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    alertView.tag = buttonIndex;
    alertView.delegate = nil;
}




-(void)onDeviceOrientationChange:(BOOL)paramAnimated {

    /**
     *页面旋屏通知回调
     *首先判断是否开启允许旋屏
     *判断旋转后当前状态栏方向。根据方向旋转View，并加载坐标
     */
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    NSString *animationsStr = [NSString stringWithFormat:@"%@OnDeviceOrientationChange",
                               NSStringFromClass([self class])];
    if (PP_ISNSLOG) {
//        NSLog(@"旋转了%@",animationsStr);
    }
    
    if (paramAnimated) {
        [UIView beginAnimations:animationsStr context:@""];
        [UIView setAnimationDuration:0.5];
    }
    
    if(interfaceOrientation == UIDeviceOrientationPortrait)
    {
        if ([PPUIKit getIsDeviceOrientationPortrait]) {
            [self setTransform:CGAffineTransformMakeRotation(0)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if ([PPUIKit getIsDeviceOrientationPortraitUpsideDown]) {
            [self setTransform:CGAffineTransformMakeRotation(M_PI)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeLeft]) {
            [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeRight]) {
            [self setTransform:CGAffineTransformMakeRotation(- M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    
    if (paramAnimated) {
        [UIView commitAnimations];
    }
}

    

-(void)dismissAlertView:(id)sender{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(alertViewIsRemoved)];
	[grayView setAlpha:0.0f];
	[UIView commitAnimations];
}

- (void)alertViewIsRemoved{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	[self removeFromSuperview];
    self = nil;
}

-(void)myLabel:(PPHyperlinkLabel *)myLabel{
    [self agreeClauseButtonPressdown];
}


@end
