//
//  UnionPayViewController.h
//  PPAppPlatformKit
//
//  Created by seven  mr on 1/25/13.
//  Copyright (c) 2013 seven  mr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPPayPlugin.h"

@interface PPUnionPayViewController : UIViewController
<
UPPayPluginDelegate,
NSURLConnectionDataDelegate,
NSURLConnectionDelegate
>
{
    NSMutableData *recvData;
    
    UIAlertView* alertView;
    UIActivityIndicatorView *indicator;
}

/**
 *  获取订单时间， 正在生成订单
 */
-(void)getUPPAYCreateTime;

/**
 *  过期
 */
//- (void)payShowWithStatusBarOrientationInt:(UIInterfaceOrientation)paramStatusBarOrientationInt;

@end
