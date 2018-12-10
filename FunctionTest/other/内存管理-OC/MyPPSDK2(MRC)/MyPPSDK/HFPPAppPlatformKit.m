//
//  HFPPAppPlatformKit.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFPPAppPlatformKit.h"
#import "PPCenterView.h"
@interface HFPPAppPlatformKit()
@property(nonatomic,retain)PPCenterView *centerView;
@end

@implementation HFPPAppPlatformKit
+(HFPPAppPlatformKit*)shareInstance{
    static HFPPAppPlatformKit *shareInstanc = nil;
    
    if (shareInstanc == nil) {
        shareInstanc = [[HFPPAppPlatformKit alloc] init];
    }
    
    return shareInstanc;
}

-(void)showCenter{
    PPCenterView *centerView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:centerView atIndex:1001];
    [centerView release];
}

-(void)dealloc{
    NSLog(@"HFPPAppPlatformKit dealloc:%p",self);
    [super dealloc];
}

@end
