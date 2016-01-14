//
//  TRUserInfo.h
//  TestSDK
//
//  Created by chenjunhong on 13-6-26.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUserInfo : NSObject
{
    NSString *_userName;
    NSString *_password;
    BOOL _isKeepPassWord;
    unsigned long long _valueId;
}

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic) BOOL isKeepPassWord;
@property (nonatomic) unsigned long long valueId;

+ (TRUserInfo *)defaultTRUserInfo;

@end
