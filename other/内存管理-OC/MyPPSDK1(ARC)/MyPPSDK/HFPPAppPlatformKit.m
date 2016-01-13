//
//  HFPPAppPlatformKit.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFPPAppPlatformKit.h"
//#import "PPCenterView.h"
#import "PPHelpView.h"
@implementation HFPPAppPlatformKit
+(HFPPAppPlatformKit*)shareInstance{
    static HFPPAppPlatformKit *shareInstanc = nil;
    
    if (shareInstanc == nil) {
        shareInstanc = [[HFPPAppPlatformKit alloc] init];
    }
    
    return shareInstanc;
}

-(void)showCenter{
    NSLog(@"showCenter");
    
    PPHelpView *ppHelpView = [[PPHelpView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppHelpView atIndex:1002];
}

@end
