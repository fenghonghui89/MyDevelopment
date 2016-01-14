//
//  PPCommon.h
//  PPAppPlatformKit
//
//  Created by Seven on 13-3-1.
//  Copyright (c) 2013年 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>
#import "PPAppPlatformKit.h"



@interface PPCommon : NSObject
{

}

/**
 *  打印错误信息
 *
 *  @param errorCode 错误Code
 */
+ (void)showMessage:(SDKUserErrorCode)errorCode;
/**
 *  打印网络错误信息
 *
 *  @param errorCode 错误Code
 */
+ (void)showConnectionErrorMessage:(TRHTTPConnectionError)errorCode;
/**
 *  检查用户名 是否包含不规范字符
 *
 *  @param paramStr 用户名
 *
 *  @return YES/NO
 */
+ (BOOL)isValidateUserName:(NSString *)paramStr;
/**
 *  设备信息
 *
 *  @return 设备信息
 */
+ (NSString *)sendDeviceKey;
/**
 *  获取 PPUUID
 *
 *  @return PPUUID
 */
+ (NSString *)PPUUID;

/**
 *  检查是否包含表情字符
 *
 *  @param string 字符串
 *
 *  @return YES/NO
 */
+(BOOL)isContainsEmoji:(NSString *)string;
/**
 *  对秘密进行签名
 *
 *  @param password 密码
 *
 *  @return 字符串
 */
+ (NSString *)md5HexDigest:(NSString*)password;
/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)getColor:(NSString *)hexColor;
/**
 *  获取字符串渲染的尺寸大小
 *
 *  @param paramStr  字符串
 *  @param paramFont 字体
 *
 *  @return 尺寸大小
 */
+ (CGSize)getTextSize:(NSString *)paramStr Font:(UIFont *)paramFont;
/**
 *  验证是否包含数字
 *
 *  @param paramStrValidate 字符串
 *
 *  @return YES/NO
 */
+ (BOOL)validateNumeric:(NSString *)paramStrValidate;
/**
 *  把一个对象 转化成 NSDictionary （键是属性名称，值是属性值）
 *
 *  @param obj 对象
 *
 *  @return NSDictionary
 */
+ (NSDictionary*)getObjectData:(id)obj;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;
/**
 *  打印 getObjectData方法返回的NSDictionary
 *
 *  @param obj 对象
 */
+ (void)print:(id)obj;

/**
 *  获取设置固件版本
 *
 *  @return 字符串
 */
+ (NSString *) _platformString;


#pragma mark - 过期方法 -
//+ (NSString *)sendPWDcheckek;



//+ (NSString *) macaddress;

@end
