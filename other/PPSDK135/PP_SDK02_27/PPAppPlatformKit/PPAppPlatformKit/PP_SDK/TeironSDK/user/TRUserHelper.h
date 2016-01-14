//
//  TRUserHelper.h
//  TestSDK
//
//  Created by chenjunhong on 13-5-28.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TeironSDK/user/TRUserRequest.h>

@class TRUserInfo, TRValueData;

@interface TRUserHelper : NSObject

+ (BOOL)isValidate:(NSString *)paramStr;

+ (NSString*)getMessageBySDKUserErrorCodeCode:(SDKUserErrorCode)errorCode;
+ (NSString*)getMessageBySDKImportRepeatUserErrorCode:(SDKImportRepeatUserErrorCode)errorCode;


/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
+ (NSData*)getDeviceLoginRecordsKey;

+ (NSData*)getDeviceLoginRecordsValueByUserInfo:(TRUserInfo*)userInfo;

+ (TRUserInfo*)getUserInfoByDeviceLoginRecordsValueData:(TRValueData*)valueData;

@end
