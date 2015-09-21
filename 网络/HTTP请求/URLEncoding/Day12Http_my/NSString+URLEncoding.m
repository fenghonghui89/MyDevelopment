//
//  NSString+URLEncoding.m
//  MyPhoneGap
//
//  Created by 关东升 on 12-5-25.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)


- (NSString *)URLEncodedString
{
    //CFURLCreateStringByAddingPercentEscapes：把内容转换成url编码
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,//指定本身为非法url字符但不进行编码的字符集合
                                            CFSTR("!*();+$,%#[] "),//本身为合法url字符但需要进行编码的字符集合
                                            kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = ( NSString *)
    //CFURLCreateStringByReplacingPercentEscapesUsingEncoding：url解码
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),//不进行解码的字符集
                                                            kCFStringEncodingUTF8));
    return result;
}

@end
