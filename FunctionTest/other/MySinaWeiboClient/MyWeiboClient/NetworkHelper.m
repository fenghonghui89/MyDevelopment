//
//  NetworkHelper.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "NetworkHelper.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@interface NetworkHelper ()<ASIHTTPRequestDelegate>
@property(nonatomic,retain)NSMutableData *receiveData;
@end

@implementation NetworkHelper

+(NetworkHelper *)shareNetworkHelper
{
    static NetworkHelper *shareInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

-(void)getDataWitPath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    ASIFormDataRequest *requeset = [ASIFormDataRequest requestWithURL:url];
    [requeset setDelegate:self];
    [requeset startAsynchronous];
}

#pragma mark - ASIHTTPRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"error:%@",[error localizedDescription]);
}

@end
