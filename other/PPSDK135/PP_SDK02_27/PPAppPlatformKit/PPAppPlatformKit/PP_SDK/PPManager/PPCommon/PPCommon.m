//
//  PPCommon.m
//  PPAppPlatformKit
//
//  Created by Seven on 13-3-1.
//  Copyright (c) 2013年 张熙文. All rights reserved.
//

#import "PPCommon.h"
#import "PPAppPlatformKitConfig.h"
#import "PPUserInfo.h"
#import "PPAlertView.h"
#import <objc/runtime.h>

@implementation PPCommon
/**
 *  打印错误信息
 *
 *  @param errorCode 错误Code
 */
+ (void)showMessage:(SDKUserErrorCode)errorCode{
    
    
    NSString *message = @"";
    if (PP_ISNSLOG) {
        NSLog(@"0X%X",errorCode);
    }
    if (errorCode == -1) {
        message = @"网络超时";
    }else if (errorCode == SDKUserErrorIllegalUserName) {
        message = @"用户名不符合规则";
    }else if (errorCode == SDKUserErrorUserNotExists) {
        message = @"用户名不存在";
    }else if (errorCode == SDKUserSuccess) {
        message = @"操作成功";
    }else if (errorCode == SDKUserErrorInvalidOperation) {
        message = @"无效的操作";
    }else if (errorCode == SDKUserErrorUserAleradyExists) {
        message = @"用户名已被使用";
    }else if (errorCode == SDKUserErrorPasswordError) {
        message = @"密码校验错误";
    }else if(errorCode == SDKUserErrorPasswordCheckError){
        message = @"密码校验错误";
        
    }else if (errorCode == SDKUserErrorBanUser) {
        message = @"密码验证错误";
    }else if (errorCode == SDKUserErrorDBError) {
        message = @"该用户被禁止登录";
    }else if (errorCode == SDKUserErrorSessionTimeout) {
        message = @"数据库错误";
    }else if (errorCode == SDKUserErrorAlreadyBind) {
        message = @"该临时账号已经绑定过正式账号，无法再绑定";
    }else if(errorCode == SDKUserErrorTryAfter10Min){
        message = @"尝试错误次数过多";
    }else{
        message = @"未知错误";
    }
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:message];
    [alert setCancelButtonTitle:@"确定" block:^{

    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
}

/**
 *  打印网络错误信息
 *
 *  @param errorCode 错误Code
 */
+ (void)showConnectionErrorMessage:(TRHTTPConnectionError)errorCode{
    NSString *message = @"";
    if (PP_ISNSLOG) {
        NSLog(@"0X%X",errorCode);
    }
    if (errorCode == -1) {
        message = @"网络超时";
    }else if (errorCode == tTRHTTPConnectionError) {
        message = @"连接失败";
    }else if (errorCode == tRHTTPConnectionErrorDataNull) {
        message = @"获取数据包异常";
    }else{
        message = @"未知错误";
    }
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:message];
    [alert setCancelButtonTitle:@"确定" block:^{

    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
}
/**
 *  检查用户名 是否包含不规范字符
 *
 *  @param paramStr 用户名
 *
 *  @return YES/NO
 */
+ (BOOL)isValidateUserName:(NSString *)paramStr{
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[paramStr componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    BOOL canChange = [paramStr isEqualToString:filtered];
    return canChange;
}

/**
 *  设备信息
 *
 *  @return 设备信息
 */
+ (NSString *)sendDeviceKey
{
    NSData *key = [[NSData alloc] initWithData:[TRUserHelper getDeviceLoginRecordsKey]];
    Byte *testByte = (Byte *)[key bytes];
    NSMutableString *tempStr = [NSMutableString stringWithString:@""];
    for(int i=0 ;i < [key length]; i++)
    {
        [tempStr appendFormat:@"%02x", testByte[i]];
    }
    [key release];
    if (PP_ISNSLOG) {
        NSLog(@"%@",tempStr);
    }
    return tempStr;
}

/**
 *  获取 PPUUID
 *
 *  @return PPUUID
 */
+ (NSString *)PPUUID
{
    return [[UIDevice currentDevice] valueForKeyPath:@"uniqueIdentifier"];
}

/**
 *  检查是否包含表情字符
 *
 *  @param string 字符串
 *
 *  @return YES/NO
 */
+(BOOL)isContainsEmoji:(NSString *)string {
    
    
    
    __block BOOL isEomji = NO;
    
    
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
             
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    
    
    return isEomji;
}
/**
 *  对秘密进行签名
 *
 *  @param password 密码
 *
 *  @return 字符串
 */
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    if(PP_ISNSLOG)
        NSLog(@"Encryption Result = %@",mdfiveString);

    return mdfiveString;
}

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)getColor:(NSString *)hexColor {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

/**
 *  获取字符串渲染的尺寸大小
 *
 *  @param paramStr  字符串
 *  @param paramFont 字体
 *
 *  @return 尺寸大小
 */
+ (CGSize)getTextSize:(NSString *)paramStr Font:(UIFont *)paramFont
{
    return [paramStr sizeWithFont:paramFont constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
}
/**
 *  验证是否包含数字
 *
 *  @param paramStrValidate 字符串
 *
 *  @return YES/NO
 */
+ (BOOL)validateNumeric:(NSString *)paramStrValidate
{
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSRange range = [paramStrValidate rangeOfCharacterFromSet:charSet];
    return (range.location == NSNotFound) ? YES : NO;
}
/**
 *  把一个对象 转化成 NSDictionary （键是属性名称，值是属性值）
 *
 *  @param obj 对象
 *
 *  @return NSDictionary
 */
+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
/**
 *  打印 getObjectData方法返回的NSDictionary
 *
 *  @param obj 对象
 */
+ (void)print:(id)obj
{
    NSLog(@"%@", [self getObjectData:obj]);
}

//不明白干嘛

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        
        return dic;
    }
    
    return [self getObjectData:obj];
}

/**
 * 获取设置固件版本 “7.9.3”
 *
 *  @return “7.9.3”
 */
+ (NSString *) _platform
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

/**
 *  获取设置固件版本
 *
 *  @return 字符串
 */
+ (NSString *) _platformString
{
    NSString *platform = [PPCommon _platform];
    if (PP_ISNSLOG) {
        NSLog(@"%@",platform);
    }

    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini2 (GSM)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini2 (GSM+CDMA)";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}


#pragma mark - 没有用到 的方法 -
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

#pragma mark - 过期方法 -



//+ (NSString *)sendPWDcheckek{
//    NSData *p = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_P"];
//
//    if (p == nil) {
//        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:[[PPAppPlatformKit sharedInstance] currentAddress] message:@"系统异常，请稍后再试"];
//        [alertView setCancelButtonTitle:@"确定" block:^{
//
//
//        }];
//        [alertView addButtonWithTitle:nil block:nil];
//        [alertView show];
//
//        return @"";
//    }
//
//
//    const char *password_ = [p bytes];
//    NSMutableString *tempStr = [NSMutableString stringWithString:@""];
//
//
////    for (int i = 0; i < sizeof(32) / sizeof(passwordHash[0]); i++) {
////        [tempStr appendFormat:@"%02x", passwordHash[i]];
////    }
//    if (PP_ISNSLOG) {
//        NSLog(@"%@",tempStr);
//    }
//    return tempStr;
//}


//+ (NSString *) macaddress
//{
//	int                    mib[6];
//	size_t                len;
//	char                *buf;
//	unsigned char        *ptr;
//	struct if_msghdr    *ifm;
//	struct sockaddr_dl    *sdl;
//
//	mib[0] = CTL_NET;
//	mib[1] = AF_ROUTE;
//	mib[2] = 0;
//	mib[3] = AF_LINK;
//	mib[4] = NET_RT_IFLIST;
//
//	if ((mib[5] = if_nametoindex("en0")) == 0) {
//		printf("Error: if_nametoindex error/n");
//		return NULL;
//	}
//
//	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//		printf("Error: sysctl, take 1/n");
//		return NULL;
//	}
//
//	if ((buf = malloc(len)) == NULL) {
//		printf("Could not allocate memory. error!/n");
//		return NULL;
//	}
//
//	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//		printf("Error: sysctl, take 2");
//		return NULL;
//	}
//
//
//
//	ifm = (struct if_msghdr *)buf;
//	sdl = (struct sockaddr_dl *)(ifm + 1);
//	ptr = (unsigned char *)LLADDR(sdl);
//	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
//	free(buf);
//	return [outstring uppercaseString];
//
//}
@end

