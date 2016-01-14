//
//  WeiBoParser.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weibo.h"
@interface WeiBoParser : NSObject

+(Weibo *)getWeiboByParserWithData:(NSDictionary *)dic;
+(WeiboUserInfo *)getWeiboUserInfoByParserWith:(NSDictionary *)dic;

+ (NSString *)parseLink:(NSString *)sourceString;
@end
