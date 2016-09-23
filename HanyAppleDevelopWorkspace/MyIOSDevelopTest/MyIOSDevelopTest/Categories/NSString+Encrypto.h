//
//  NSString+Crypto.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypto)
- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;
@end
