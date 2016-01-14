//
//  PPGameUpdateManager.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-28.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TeironSDK/net/TRHTTPConnection.h>
#import <TeironSDK/net/TRBuffer.h>
#import "PPGameVersion.h"

//static NSString * const GAMEUPDATE_REQUEST_URL = @"http://passport_i.25pp.com:8008/i"; //测试
static NSString * const GAMEUPDATE_REQUEST_URL = @"http://passport_i.25pp.com/i"; //正式
static int const IH_REQ_QUR_GAMEUPDATE = 0xFEC00110;


@class PPGameUpdateManager;
@protocol PPGameUpdateManagerDelegate <NSObject>
/**
 *  检查版本跟新 成功
 *
 *  @param gameVersion 数据
 */
- (void)didSuccessGetGameUpdateInfoCallBack:(PPGameVersion *)gameVersion;

/**
 *  检查版本更新 失败
 *
 *  @param errorCode 错误Code
 *  @param userInfo  用户信息
 */
- (void)didFailRequestConnectionCallBack:(TRHTTPConnectionError)errorCode
                                userInfo:(NSMutableDictionary *)userInfo;

@optional

@end

@interface PPGameUpdateManager : NSObject
<
TRHTTPConnectionDelegate
>
{
    id<PPGameUpdateManagerDelegate> _delegate;
    TRHTTPConnection *_conn;
}

+ (id)defaultPPGameUpdateManager;
/**
 *  检查版本更新
 *
 *  @param delegate 代理
 */
- (void)ppRequestGameVersionWithDelegate:(id<PPGameUpdateManagerDelegate>)delegate;
@end
