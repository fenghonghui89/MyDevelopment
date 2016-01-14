//
//  SpendingRecordTableViewCell.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-20.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPSpendingRecordTableViewCell.h"
#import "PPUIKit.h"
#import "PPCommon.h"

@implementation PPSpendingRecordTableViewCell


@synthesize timeLabel,orderIdLabel,spendingAmountLabel,gameNameLabel,orderStatusLabel;

- (id)init{
    self = [super init];
    if (self) {

        //1、消费时间label
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
        
        //3、消费金额label
        spendingAmountLabel = [[UILabel alloc]init];
        //        [rechargeAmountLabel setFrame:CGRectMake( 138, 0, 50, 44)];
        [spendingAmountLabel setBackgroundColor:[UIColor clearColor]];
        [spendingAmountLabel setTextAlignment:NSTextAlignmentCenter];
        spendingAmountLabel.font = [UIFont systemFontOfSize:9.0f];
        [spendingAmountLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:spendingAmountLabel];
        [spendingAmountLabel release];
        
        
        //5、游戏名称label
        gameNameLabel = [[UILabel alloc]init];
        //        [rechargeTypeLabel setFrame:CGRectMake( 238, 0, 37, 44)];
        [gameNameLabel setBackgroundColor:[UIColor clearColor]];
        [gameNameLabel setTextAlignment:NSTextAlignmentCenter];
        gameNameLabel.font = [UIFont systemFontOfSize:9.0f];
        [gameNameLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:gameNameLabel];
        [gameNameLabel release];
        
        //6、到账状态label
        orderStatusLabel = [[UILabel alloc]init];
        //        [rechargeStatusLabel setFrame:CGRectMake( UI_SCREEN_WIDTH-45, 0, 40, 44)];
        [orderStatusLabel setBackgroundColor:[UIColor clearColor]];
        [orderStatusLabel setTextAlignment:NSTextAlignmentCenter];
        orderStatusLabel.font = [UIFont systemFontOfSize:9.0f];
        [orderStatusLabel setTextColor:COLOR(2, 2, 2, 1)];
        [self addSubview:orderStatusLabel];
        [orderStatusLabel release];
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
    [spendingAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x+orderIdLabel.frame.size.width, 0, 50, 44)];
    [gameNameLabel setFrame:CGRectMake(spendingAmountLabel.frame.origin.x+spendingAmountLabel.frame.size.width, 0, 100, 44)];
    [orderStatusLabel setFrame:CGRectMake(gameNameLabel.frame.origin.x+gameNameLabel.frame.size.width, 0, 27, 44)];
    
}

//横
-(void)initHorizontalFrame{
    
    int widthIncrement = 0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //iPad处理部分
        widthIncrement = (UI_IPHONE_SCREEN_HEIGHT - 320) / 4;
        
    }else{
        //iPhone处理部分
        widthIncrement = (UI_SCREEN_HEIGHT - 320) / 4;
    }

    //table的标签view，显示table内容文字的label
    [timeLabel setFrame:CGRectMake(16, 0, 27 + widthIncrement, 44)];
    [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95 + widthIncrement, 44)];
    [spendingAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x+orderIdLabel.frame.size.width, 0, 50 + widthIncrement, 44)];
    [gameNameLabel setFrame:CGRectMake(spendingAmountLabel.frame.origin.x+spendingAmountLabel.frame.size.width, 0, 100 + widthIncrement, 44)];
    [orderStatusLabel setFrame:CGRectMake(gameNameLabel.frame.origin.x+gameNameLabel.frame.size.width, 0, 27, 44)];
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







- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [super dealloc];
}

@end
