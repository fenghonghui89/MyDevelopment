//
//  HFCommon.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-14.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFCommon : NSObject
//计算字符串所占空间
+(CGSize)getStringSizeWithString:(NSString *)content andFont:(UIFont *)font andWidth:(float)width andHeight:(float)height;
//获取bundle下的图片
+(UIImage *)getImagePathWithDirectoryName:(NSString *)directoryName andImageName:(NSString *)imageName;

+(float)getTextHeightWithFontSize:(float)paramFontSize andWidth:(float)paramWidth andText:(NSString *)text;
@end
