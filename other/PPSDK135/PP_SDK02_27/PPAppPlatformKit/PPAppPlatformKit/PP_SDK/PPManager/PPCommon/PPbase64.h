//
//  PPBase64.h
//  PPAppPlatformKit
//
//  Created by 熙文 张 on 13-12-30.
//  Copyright (c) 2013年 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBase64 : NSObject

extern size_t PPEstimateBas64EncodedDataSize(size_t inDataSize,BOOL wrapped);
extern size_t PPEstimateBas64DecodedDataSize(size_t inDataSize);

extern bool PPBase64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize, BOOL wrapped);
extern bool PPBase64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);

@end
