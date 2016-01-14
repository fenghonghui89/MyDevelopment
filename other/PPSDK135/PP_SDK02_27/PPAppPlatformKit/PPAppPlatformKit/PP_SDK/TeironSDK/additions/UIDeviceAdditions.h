//
//  UIDeviceAdditions.h
//  TeironSDK
//
//  Created by chenjunhong on 13-5-10.
//  Copyright (c) 2013年 Jun. All rights reserved.
//


@interface UIDeviceAdditions : UIDevice

+ (NSData*)getValue:(NSString*)key;
+ (NSString*)getPlatform;
+ (uint64_t)getECID;
+ (NSString*)getECIDStr;
+ (NSString*)getSN;
+ (NSString *)getMacAddress;

@end
