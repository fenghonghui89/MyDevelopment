//
//  NSString+Category.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/25.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/**
 *  判断是否空字符串
 *
 *
 *  @return bool
 */
- (BOOL) isBlankString;

-(NSString *)stringByWithoutSpace;
/**
 *  正则判断邮箱
 *
 *  @param candidate 邮箱
 *
 *  @return bool
 */
-(BOOL) validateEmail;

/**
 *  正则判断手机号码地址格式
 *
 *  @param mobileNum 手机号
 *
 *  @return bool
 */
-(BOOL)isMobileNumber;

/**
 *  ip正则判断
 *
 *  @return bool
 */
-(BOOL)validIpAddress;

@end
