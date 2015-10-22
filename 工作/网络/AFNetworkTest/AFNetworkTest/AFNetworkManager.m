//
//  AFNetworkManager.m
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworkManager.h"
#import "AFNetworking.h"
@interface AFNetworkManager()
@end
@implementation AFNetworkManager
+(AFNetworkManager *)share
{
    static AFNetworkManager *share = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

-(void)request
{
    // 1
    NSString *urlStr = @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *requestBody = [@"theCityCode=江门&theUserID=" dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];

    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"请求成功");
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
@end
