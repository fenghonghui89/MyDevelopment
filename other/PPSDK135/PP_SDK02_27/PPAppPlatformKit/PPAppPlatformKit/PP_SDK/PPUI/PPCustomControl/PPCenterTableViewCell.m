//
//  PPCenterTableViewCell.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-9-27.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPCenterTableViewCell.h"
#import "PPUIKit.h"
#import "PPAppPlatformKitConfig.h"
#import "PPCommon.h"
#import "PPBaseView.h"

@implementation PPCenterTableViewCell

@synthesize titleIamgeView;
@synthesize titleLabel;
@synthesize actionImageView;

@synthesize valueLabel,actionButton,tintLabel;

-(id)init{
    
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        
        titleIamgeView=[[UIImageView alloc]init];
        [titleIamgeView setContentMode:UIViewContentModeRight];
        [self addSubview:titleIamgeView];
        [titleIamgeView release];
        
        titleLabel=[[UILabel alloc]init];
        [titleLabel setFrame:CGRectMake( 81, 7, 100, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        
        [actionButton setBackgroundColor:[UIColor redColor]];
        
        actionImageView=[[UIImageView alloc]init];
        [actionImageView setImage:[PPUIKit setLocaImage:@"nextLevelArrow"]];
        [self addSubview:actionImageView];
        [actionImageView release];
        
        [self onDeviceOrientationChange2:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange2:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
    }
    return self;
}

//按照当前屏幕方向设置ui坐标
-(void)onDeviceOrientationChange2:(BOOL)paramAnimated {
    
    /**
     *页面旋屏通知回调
     *首先判断是否开启允许旋屏
     *判断旋转后当前状态栏方向。根据方向旋转View，并加载坐标
     */
    
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    if(interfaceOrientation == UIDeviceOrientationPortrait)
    {
        if ([PPUIKit getIsDeviceOrientationPortrait]) {
//            [self setTransform:CGAffineTransformMakeRotation(0)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if ([PPUIKit getIsDeviceOrientationPortraitUpsideDown]) {
//            [self setTransform:CGAffineTransformMakeRotation(M_PI)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeLeft]) {
//            [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeRight]) {
//            [self setTransform:CGAffineTransformMakeRotation(- M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    
    if (paramAnimated) {
        [UIView commitAnimations];
    }
}

//竖屏状态下的ui位置
-(void)initVerticalFrame{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        [titleIamgeView setFrame:CGRectMake( 16, 7.5, 29, 29)];
        [actionImageView setFrame:CGRectMake( UI_IPHONE_SCREEN_WIDTH - 25, 15.5, 9, 13)];
        [valueLabel setFrame:CGRectMake( titleLabel.frame.origin.x+titleLabel.frame.size.width+16, 7, 150,30 )];
        [actionButton setFrame:CGRectMake( UI_IPHONE_SCREEN_WIDTH - 65, 0, 50 + 16,self.frame.size.height )];
        [tintLabel setFrame:CGRectMake(actionImageView.frame.origin.x-116, 7, 100, 30)];
    }else{
        
        [titleIamgeView setFrame:CGRectMake( 16, 7.5, 29, 29)];
        [actionImageView setFrame:CGRectMake( UI_SCREEN_WIDTH-25, 15.5, 9, 13)];
        [valueLabel setFrame:CGRectMake( titleLabel.frame.origin.x + titleLabel.frame.size.width + 16, 7, 150,30 )];
        [actionButton setFrame:CGRectMake( UI_SCREEN_WIDTH - 65, 0, 50 + 10,self.frame.size.height )];
        [tintLabel setFrame:CGRectMake(actionImageView.frame.origin.x - 116, 7, 100, 30)];
    }
    
    
    
}
//横屏状态下的ui位置
-(void)initHorizontalFrame{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        [titleLabel setFrame:CGRectMake( 16, 7, 80, 30)];
        [titleIamgeView setFrame:CGRectMake( 16, 7.5, 29, 29)];
        [actionImageView setFrame:CGRectMake( UI_IPHONE_SCREEN_HEIGHT-25-20, 15.5, 9, 13)];
        [valueLabel setFrame:CGRectMake( 112, 7,UI_IPHONE_SCREEN_HEIGHT-199,30 )];
        [actionButton setFrame:CGRectMake( UI_IPHONE_SCREEN_HEIGHT - 65 - 20, 0, 50 + 20,self.frame.size.height )];
        [tintLabel setFrame:CGRectMake(actionImageView.frame.origin.x-116, 7, 100, 30)];
    }else{
        [titleIamgeView setFrame:CGRectMake(16, 7.5, 29, 29)];
        [actionImageView setFrame:CGRectMake(UI_SCREEN_HEIGHT-25, 15.5, 9, 13)];
        [actionButton setFrame:CGRectMake(UI_SCREEN_HEIGHT - 65, 0, 50 + 20, self.frame.size.height )];
        [valueLabel setFrame:CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 16, 7,
                                        UI_SCREEN_HEIGHT - 67 - (titleLabel.frame.origin.x + 16 + titleLabel.frame.size.width),30 )];
        [tintLabel setFrame:CGRectMake(actionImageView.frame.origin.x-116, 7, 100, 30)];
    }
    
}
//PP中心中不带图标的cell的初始化方式
-(id)initWithLabelType{
    
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        
        titleLabel=[[UILabel alloc]init];
        [titleLabel setFrame:CGRectMake( 16, 7, 80, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
//        [titleLabel setContentMode:UIViewContentModeCenter];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:titleLabel];
        [titleLabel release];        
        valueLabel=[[UILabel alloc]init];
        
        [valueLabel setBackgroundColor:[UIColor clearColor]];
//        [valueLabel setContentMode:UIViewContentModeRight];
        [valueLabel setTextAlignment:NSTextAlignmentRight];
        [valueLabel setFont:[UIFont systemFontOfSize:15]];
        [valueLabel setText:@"卡哇伊伊"];
        [self addSubview:valueLabel];
        [valueLabel release];
        
        actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [actionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [actionButton setBackgroundColor:[UIColor clearColor]];
//        [actionButton setBackgroundColor:[UIColor redColor]];
//        [actionLabel setContentMode:UIViewContentModeCenter];
        [[actionButton titleLabel] setTextAlignment:NSTextAlignmentRight];
        [actionButton setTitle:@"充值" forState:UIControlStateNormal];
        [[actionButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [actionButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self addSubview:actionButton];
        
        
        [self onDeviceOrientationChange2:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange2:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

//PP中心中带图标的cell的初始化方式
-(id)initWithDefaultType{
    
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        titleIamgeView=[[UIImageView alloc] init];
        //        [titleIamgeView setImage:[PPUIKit setLocaImage:@"PPTitleUserCenter"]];
        
        [titleIamgeView setContentMode:UIViewContentModeCenter];
        [self addSubview:titleIamgeView];
        [titleIamgeView release];
        
        titleLabel=[[UILabel alloc] init];
        [titleLabel setFrame:CGRectMake( 81, 7, 140, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        tintLabel = [[UILabel alloc] init];
        [tintLabel setBackgroundColor:[UIColor clearColor]];
        [tintLabel setTextAlignment:NSTextAlignmentRight];
        [tintLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:tintLabel];
        [tintLabel release];
        
        actionImageView=[[UIImageView alloc] init];
        [actionImageView setImage:[PPUIKit setLocaImage:@"nextLevelArrow"]];
        [self addSubview:actionImageView];
        [actionImageView release];
        
        
        
        
        
        [self onDeviceOrientationChange2:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange2:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetFillColorWithColor(context,  [PPCommon getColor:@"cccccc"].CGColor);
    
    //这种线要画到x=0
    if(self.tag == 0){
        CGContextFillRect (context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 1));
    }
    //这种线要画到x=16
    if(self.tag == 1){
        CGContextFillRect(context, CGRectMake(16, rect.size.height - 0.5, rect.size.width, 1));
    }
    //这种线要画到x=61
    if(self.tag == 2){
        CGContextFillRect(context, CGRectMake(61, rect.size.height - 0.5, rect.size.width, 1));
    }
    //这种线要画到x=61
    if(self.tag == 3){
        CGContextSetFillColorWithColor(context, [PPCommon getColor:@"f0eff3"].CGColor);
        CGContextFillRect(context, rect);
        CGContextSetFillColorWithColor(context,  [PPCommon getColor:@"cccccc"].CGColor);
        CGContextFillRect (context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 1));
    }
    CGContextStrokePath(context);
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];    
    [super dealloc];
}

@end
