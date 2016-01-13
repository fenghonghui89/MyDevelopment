//
//  PPWebViewData.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "PPWebViewData.h"
@interface PPWebViewData()
@property(nonatomic,strong)PPHttpRequest *ppHttpRequest;
@end

@implementation PPWebViewData

-(void)getHelpViewData{
    NSLog(@"getHelpViewData");
    PPHttpRequest *ppHttpRequest = [[PPHttpRequest alloc] init];
    [ppHttpRequest setDelegate:self];
    [ppHttpRequest connectToPPServerAndGetHelpViewData];
//    self.ppHttpRequest = ppHttpRequest;
}

#pragma mark - ppHttpRequestDelegate -
-(void)ppHttpRequest:(PPHttpRequest *)ppHttpRequest andParmaDic:(NSDictionary *)parmaDic{
    NSLog(@"ppHttpRequest回调");
    [self.delegate webViewData:self andPPHelpViewData:parmaDic];
}

@end
