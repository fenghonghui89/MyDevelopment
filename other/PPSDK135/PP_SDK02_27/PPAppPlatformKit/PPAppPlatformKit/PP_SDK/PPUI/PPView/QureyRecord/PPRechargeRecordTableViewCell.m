//
//  PPRechargeRecordTableViewCell.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPRechargeRecordTableViewCell.h"
#import "PPUIKit.h"
#import "PPRechargeRecordView.h"
#import "PPAppPlatformKit.h"

@implementation PPRechargeRecordTableViewCell

@synthesize timeLabel, orderIdLabel, rechargeAmountLabel, arrivedAmountLabel, rechargeTypeLabel, rechargeStatusLabel;

//默认的初始化方法,即查询条件那几个cell
-(id)init{
    self = [super init];
    if(self){
        //1、充值时间label
        timeLabel = [[UILabel alloc]init];
//        [timeLabel setFrame:CGRectMake( 16, 0, 27, 44)];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        timeLabel.font = [UIFont systemFontOfSize:9.0f];
        [timeLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:timeLabel];
        [timeLabel release];
        
        //2、订单号码label
        orderIdLabel = [[UILabel alloc]init];
//        [orderIdLabel setFrame:CGRectMake( 16+timeLabel.frame.size.width, 0, 95, 44)];
        [orderIdLabel setBackgroundColor:[UIColor clearColor]];
        [orderIdLabel setTextAlignment:NSTextAlignmentCenter];
        orderIdLabel.font = [UIFont systemFontOfSize:9.0f];
        [orderIdLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:orderIdLabel];
        [orderIdLabel release];
        
        //3、充值金额label
        rechargeAmountLabel = [[UILabel alloc]init];
//        [rechargeAmountLabel setFrame:CGRectMake( 138, 0, 50, 44)];
        [rechargeAmountLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeAmountLabel setTextAlignment:NSTextAlignmentCenter];
        rechargeAmountLabel.font = [UIFont systemFontOfSize:9.0f];
        [rechargeAmountLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:rechargeAmountLabel];
        [rechargeAmountLabel release];
        
        //4、实际到账label
        arrivedAmountLabel = [[UILabel alloc]init];
//        [arrivedAmountLabel setFrame:CGRectMake( 188, 0, 50, 44)];
        [arrivedAmountLabel setBackgroundColor:[UIColor clearColor]];
        [arrivedAmountLabel setTextAlignment:NSTextAlignmentCenter];
        arrivedAmountLabel.font = [UIFont systemFontOfSize:9.0f];
        [arrivedAmountLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:arrivedAmountLabel];
        [arrivedAmountLabel release];
        
        //5、充值方式label
        rechargeTypeLabel = [[UILabel alloc]init];
//        [rechargeTypeLabel setFrame:CGRectMake( 238, 0, 37, 44)];
        [rechargeTypeLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeTypeLabel setTextAlignment:NSTextAlignmentCenter];
        rechargeTypeLabel.font = [UIFont systemFontOfSize:9.0f];
        [rechargeTypeLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:rechargeTypeLabel];
        [rechargeTypeLabel release];
        
        //6、到账状态label
        rechargeStatusLabel = [[UILabel alloc]init];
//        [rechargeStatusLabel setFrame:CGRectMake( UI_SCREEN_WIDTH-45, 0, 40, 44)];
        [rechargeStatusLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeStatusLabel setTextAlignment:NSTextAlignmentCenter];
        rechargeStatusLabel.font = [UIFont systemFontOfSize:9.0f];
        [rechargeStatusLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:rechargeStatusLabel];
        [rechargeStatusLabel release];
        
    }
    [self onDeviceOrientationChange:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    return self;

}





//竖
-(void)initVerticalFrame{
    
    //table的标签view，显示table内容文字的label
    [timeLabel setFrame:CGRectMake(16, 0, 27, 44)];
    [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x+timeLabel.frame.size.width, 0, 95, 44)];
    [rechargeAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x+orderIdLabel.frame.size.width, 0, 45, 44)];
    [arrivedAmountLabel setFrame:CGRectMake(rechargeAmountLabel.frame.origin.x+rechargeAmountLabel.frame.size.width, 0, 45, 44)];
    [rechargeTypeLabel setFrame:CGRectMake(arrivedAmountLabel.frame.origin.x+arrivedAmountLabel.frame.size.width, 0, 47, 44)];
    [rechargeStatusLabel setFrame:CGRectMake(rechargeTypeLabel.frame.origin.x+rechargeTypeLabel.frame.size.width, 0, 40, 44)];

}

//横
-(void)initHorizontalFrame{
    
//    [super initHorizontalFrame];

    int widthIncrement = 0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //iPad处理部分
        widthIncrement = (UI_IPHONE_SCREEN_HEIGHT - 320) / 5;
        
    }else{
        //iPhone处理部分
        widthIncrement = (UI_SCREEN_HEIGHT - 320) / 5;
    }
    //table的标签view，显示table内容文字的label
    [timeLabel setFrame:CGRectMake(16, 0, 27 + widthIncrement, 44)];
    [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95 + widthIncrement, 44)];
    [rechargeAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 50  + widthIncrement, 44)];
    [arrivedAmountLabel setFrame:CGRectMake(rechargeAmountLabel.frame.origin.x + rechargeAmountLabel.frame.size.width, 0, 50 + widthIncrement, 44)];
    [rechargeTypeLabel setFrame:CGRectMake(arrivedAmountLabel.frame.origin.x + arrivedAmountLabel.frame.size.width, 0, 37 + widthIncrement, 44)];
    [rechargeStatusLabel setFrame:CGRectMake(rechargeTypeLabel.frame.origin.x + rechargeTypeLabel.frame.size.width, 0, 40, 44)];
}

//按照当前屏幕方向设置ui坐标
-(void)onDeviceOrientationChange:(BOOL)paramAnimated {
    
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];    
    [super dealloc];
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
