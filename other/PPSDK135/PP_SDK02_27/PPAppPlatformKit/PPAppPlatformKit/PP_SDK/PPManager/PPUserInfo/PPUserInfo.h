//
//  UserInfo.h
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPAppPlatformKit.h"
#import "PPAppPlatformKitConfig.h"
#import "PPOnlineNet.h"
#import "PPAccountsSecurityCenter.h"




@interface PPUserInfo : NSObject
<
NSURLConnectionDelegate
>
{
    NSString *_userName;
    NSString *_passWord;
    BOOL _isRecordPassWord;
    BOOL _isAutoLogin;
    NSMutableData *recvData;

//    NSURLConnection *connection;
}
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *passWord;
@property (nonatomic, assign) BOOL isRecordPassWord;
@property (nonatomic, assign) BOOL isAutoLogin;

/**
 *  第一次安装，升级安装，本地记录文件不存在时会去服务端获取该设备下注册过的用户名列表
 */
- (void)firstGetUserNameArrayByNet;


/**
 *  从SDK 登录  （过期）
 */

- (void)loginFromSdk:(NSString *)paramUserName PassWord:(NSString *)paramPassWord;

@end
