//
//  UserInfo.m
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPUserInfo.h"
#import "PPAppPlatformKit.h"
#import "PPCommon.h"
#import "PPMakeUser.h"
#import <TeironSDK/util/TRUtil.h>


@implementation PPUserInfo

@synthesize userName = _userName;
@synthesize passWord = _passWord;
@synthesize isRecordPassWord = _isRecordPassWord;
@synthesize isAutoLogin = _isAutoLogin;


/**
 *  第一次安装，升级安装，本地记录文件不存在时会去服务端获取该设备下注册过的用户名列表
 */
- (void)firstGetUserNameArrayByNet{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN)");
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uuid\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,
                                 [PPCommon PPUUID]];
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_GETUSERNAMELIST_SDKADDRESS];
    
    
    //    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    if (PP_ISNSLOG) {
        NSLog(@"第一次运行获取所有用户名requsetBodyData--\n%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    
    [self sendRequest:request];
}

-(void)sendRequest:(NSMutableURLRequest *)paramRequest
{
    if (![NSURLConnection canHandleRequest:paramRequest])
    {
        return;
    }
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:paramRequest delegate:self];
    if (recvData) {
        [recvData release];
        recvData = nil;
    }
    if(connection){
        recvData = [[NSMutableData alloc] init];
    }
    [connection start];
    [connection release];
    
}

#pragma mark - NSURLConnectionDelegate -

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [recvData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [recvData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION object:nil];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (PP_ISNSLOG) {
        NSLog(@"开始返回响应");
    }
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
    [recvData release];
    recvData = nil;
    if (conDidFinishDic != nil){
        if (![conDidFinishDic isKindOfClass:[NSDictionary class]]){
            
        }
    }
    
    if (PP_ISNSLOG) {
        
        NSLog(@"请求响应返回的字典%@",conDidFinishDic);
    }
    if (conDidFinishDic == nil) {
        //如果conDidFinishDic和recvData这个为空只有没有设备注册过用户。获取列表时候为空返回通知取消菊花加载即可
        [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_GETUSERNAMELIST_NOTIFICATION object:nil];
        NSString *fileNamePath = [PP_RECORDUSERINFO_PATH stringByAppendingPathComponent:PP_RECORDUSERINFO_FILENAME];
        BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:fileNamePath];
        if (!isFileExist) {
            //                [[NSFileManager defaultManager] createFileAtPath:fileNamePath contents:nil attributes:nil];
        }
        return;
    }
    NSMutableArray *sendUserNameList = [[NSMutableArray alloc] init];
    NSString *getSDKName = [conDidFinishDic objectForKey:@"sdk_name"];
    if ([getSDKName isEqualToString:PP_PHP_RESPONSE_GETUSERNAMELIST_SDKNAME]) {
        if ([[conDidFinishDic objectForKey:@"error"] intValue] == 0) {

            NSMutableArray *userNameList = [conDidFinishDic objectForKey:@"data"];
            for (int i = 0; i < [userNameList count]; i++) {
                NSString *userName = [[userNameList objectAtIndex:i] objectForKey:@"username"];
                [sendUserNameList insertObject:userName atIndex:0];
//                PPUserInfo *ppUserInfo = [[PPUserInfo alloc] init];
//                [ppUserInfo setUserName:userName];
//                [ppUserInfo setIsRecordPassWord:YES];
//                [ppUserInfo setIsAutoLogin:YES];
//                [self setRecordUserInfo:ppUserInfo];
//                [ppUserInfo release];
            }

        }else{
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_GETUSERNAMELIST_NOTIFICATION object:sendUserNameList];

    }else if([getSDKName isEqualToString:@"loginFromSdk"]){
        
    }
    [sendUserNameList release];
    [recvData release];
    recvData = nil;
}



#pragma mark - Dealloc -

- (void)dealloc
{
    self.userName = nil;
    self.passWord = nil;
    
    [super dealloc];
}

#pragma mark - 过期方法 -

/**
 *  从SDK 登录  （过期）
 */
- (void)loginFromSdk:(NSString *)paramUserName PassWord:(NSString *)paramPassWord{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN-loginFromSdk)");
    }
    
    const char *password_ = [paramPassWord UTF8String];
    unsigned char passwordHash[32];
    sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
    
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\"}",
                                 paramUserName,paramPassWord];
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHPREQUEST_LOGINFROMSDK_SDKADDRESS];
    
    
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    if (PP_ISNSLOG) {
        
        NSLog(@"loginFromSdk用户名requsetBodyData--\n%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    
    [self sendRequest:request];
}


@end
