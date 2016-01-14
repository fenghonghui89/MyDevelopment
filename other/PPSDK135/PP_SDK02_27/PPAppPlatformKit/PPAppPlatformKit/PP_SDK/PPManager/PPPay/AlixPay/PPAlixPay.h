//
//  PPAlixPay.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-7-16.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AlixPayResult.h"

@interface PPAlixPay : NSObject
<
    NSURLConnectionDataDelegate,
    NSURLConnectionDelegate
>
{
    NSMutableData *recvData;
    UIAlertView *alertView;
    UIActivityIndicatorView *indicator;
}

-(void)showViewDidLoad;
- (void)handleOpenURL:(NSURL *)url;

@end
