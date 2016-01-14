//
//  TRKeyValueHelper.h
//  TestSDK
//
//  Created by chenjunhong on 13-6-7.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TeironSDK/keyvalue/TRKeyValue.h>

@interface TRKeyValueHelper : NSObject

+ (NSString*)getMessageBySDKKeyValueRequestErrorCode:(SDKKeyValueRequestErrorCode)errorCode;

+ (NSMutableData*)getValueData;
//+ (NSData*)compress:(NSData*)source;
//+ (NSData*)decompression:(NSData*)source;

@end
