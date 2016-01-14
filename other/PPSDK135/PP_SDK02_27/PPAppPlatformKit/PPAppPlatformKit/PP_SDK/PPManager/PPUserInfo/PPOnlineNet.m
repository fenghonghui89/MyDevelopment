//
//  PPOnlineNet.m
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//



#import "PPOnlineNet.h"
#import <TeironSDK/user/TRUserHelper.h>
#import "PPCommon.h"
#import "MobileGestalt.h"


@implementation PPOnlineNet

/**
 *  统计用户注册 和 统计在线心跳 请求
 *
 *  @param paramAddress 地址
 *  @param paramUserId  用户ID
 */

-(void)ppAppOnlineRequest:(NSString *)paramAddress UserId:(u_int64_t)paramUserId
{
    
    NSString *deviceKey = [PPCommon sendDeviceKey];
    CFStringRef value = MGCopyAnswer(kMGInverseDeviceID);
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"ppKey\":\"%@\",\"uid\":\"%llu\",\"app_id\":\"%d\",\"uuid\":\"%@\",\"deviceKey\":\"%@\",\"model\":\"%@\",\"systemVersion\":\"%@\",\"version\":\"%@\",\"JailBreak\":\"%d\",\"reserveUnique\":\"%@\"}",
                                 PUBLICKEY,paramUserId,PP_REQUEST_APPID,
                                 [[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)],
                                 deviceKey,[PPCommon _platformString],
                                 [[UIDevice currentDevice] systemVersion]
                                 ,PP_REQUEST_VERSION,[[PPAppPlatformKit sharedInstance] isJailBreak],value];
    
    
    
    NSURL *requestUrl = [[NSURL alloc] initWithString:[paramAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (![[PPCommon _platformString] isEqualToString:@"iPhone Simulator"]) {
        CFRelease(value);
    }

    if (PP_ISNSLOG) {
        NSLog(@"注册统计/在线心跳统计 接口请求requsetBodyData--\n%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",paramAddress);
    }
    
    [self sendRequest:request];
    [requestUrl release];
}

/**
 *  根据用户ID和请求地址统计用户注册
 *
 *  @param paramUserId 当前登陆用户ID
 */
-(void)ppAppOnlineRegistRequest:(u_int64_t)paramUserId
{
    NSString *url = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_APPONLINEREG_SDKADDRESS];
    [self ppAppOnlineRequest:url UserId:paramUserId];
}

/**
 *  根据用户ID和请求地址统计在线心跳
 *
 *  @param paramUserId 当前登陆用户ID
 */
-(void)ppAppOnlineHrateRequest:(u_int64_t)paramUserId
{
    NSString *url = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_APPONLINEHRATE_SDKADDRESS];
    [self ppAppOnlineRequest:url UserId:paramUserId];
}
/**
 *  发生请求
 *
 *  @param request 请求
 */
-(void)sendRequest:(NSMutableURLRequest *)request
{
    if (![NSURLConnection canHandleRequest:request])
    {
        return;
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [connection release];
    connection = nil;
}


@end
