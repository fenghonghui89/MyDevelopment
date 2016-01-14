//
//  TRValueData.h
//  TestSDK
//
//  Created by chenjunhong on 13-6-19.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRValueData : NSObject
{
    unsigned long long _valueId;
    NSData *_value;
    unsigned int _lastModify;
}

+ (id)defaultTRValueData;

@property (nonatomic) unsigned long long valueId;
@property (nonatomic, retain) NSData *value;
@property (nonatomic) unsigned int lastModify;

@end
