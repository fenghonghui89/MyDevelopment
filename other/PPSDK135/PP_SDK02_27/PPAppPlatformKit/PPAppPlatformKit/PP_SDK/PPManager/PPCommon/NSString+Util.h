//
//  NSString+Util.h
//  PPAppInstall
//
//  Created by kang on 13-11-8.
//  Copyright (c) 2013年 kosin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
- (NSString *)downurlBase64ConverToNomalUrl;
- (NSString *)encodeStringToBase64;
- (NSString *)decodeBase64ToString;
- (NSString *)encodeStringToBase64URLFormat;
- (NSString *)decodeBase64URLFormatToString;
@end
