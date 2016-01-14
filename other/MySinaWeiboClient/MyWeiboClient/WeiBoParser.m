//
//  WeiBoParser.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "WeiBoParser.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
@implementation WeiBoParser

+(Weibo *)getWeiboByParserWithData:(NSDictionary *)dic
{
    Weibo *weibo = [[Weibo alloc] init];
    
    weibo.created_at = [dic objectForKey:@"created_at"];
    weibo.source = [self getSourceBySourceStr:[dic objectForKey:@"source"]];
    weibo.text = [dic objectForKey:@"text"];
    weibo.reposts_count = [dic objectForKey:@"reposts_count"];
    weibo.comments_count = [dic objectForKey:@"comments_count"];
    
    NSArray *pic_urls_dic = [dic objectForKey:@"pic_urls"];
    NSMutableArray *pics = [NSMutableArray array];
    for (NSDictionary *pic in pic_urls_dic) {
        NSURL *url = [pic objectForKey:@"thumbnail_pic"];
        [pics addObject:url];
    }
    weibo.pic_urls = pics;
    
    NSDictionary *retweetedDic = [dic objectForKey:@"retweeted_status"];
    if (retweetedDic) {
        weibo.retweeted_status = [self getWeiboByParserWithData:retweetedDic];
    }
    
    weibo.weiboUserInfo = [self getWeiboUserInfoByParserWith:[dic objectForKey:@"user"]];
    
    return weibo;
}

+(NSString *)getSourceBySourceStr:(NSString *)paramSourceStr
{
    NSString *str = [paramSourceStr substringToIndex:paramSourceStr.length - 4];
    NSArray *arr = [str componentsSeparatedByString:@">"];
    return  [arr lastObject];
}

+(WeiboUserInfo *)getWeiboUserInfoByParserWith:(NSDictionary *)dic
{
    WeiboUserInfo *weiboUserInfo = [[WeiboUserInfo alloc] init];
    
    weiboUserInfo.screen_name = [dic objectForKey:@"screen_name"];
    weiboUserInfo.profile_image_url = [dic objectForKey:@"profile_image_url"];
    
    return weiboUserInfo;
}

#pragma mark - 正则表达式筛选替换匹配内容
+ (NSString *)parseLink:(NSString *)sourceString
{
    //定义正则表达式
    NSString *regexString = @"(@[\\w-]+)|(#\\w+#)|(http(s)?://[A-Za-z0-9.-_?/]*)";

    //根据正则表达式提取匹配的部分
    NSArray *components = [sourceString componentsMatchedByRegex:regexString];
    
    //对三种不同形式的链接，进行内容修改（用户、话题、网址）
    for (NSString *component in components) {
        NSString *replacedString = nil;
        
        if ([component hasPrefix:@"@"]) {
            replacedString = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>", [component URLEncodedString], component];
        }
        if ([component hasPrefix:@"#"]) {
            replacedString = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>", [component URLEncodedString], component];
        }
        if ([component hasPrefix:@"http://"]) {
            replacedString = [NSString stringWithFormat:@"<a href='%@'>%@</a>", component, component];
        }
        
        if (components.count > 0) {
            sourceString = [sourceString stringByReplacingOccurrencesOfString:component withString:replacedString];
        }
    }
    
    return sourceString;
}

@end
