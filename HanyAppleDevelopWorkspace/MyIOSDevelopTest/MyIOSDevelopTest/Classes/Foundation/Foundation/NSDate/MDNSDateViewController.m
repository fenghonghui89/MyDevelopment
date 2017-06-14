//
//  MDNSDateViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSDateViewController.h"

@interface MDNSDateViewController ()

@end

@implementation MDNSDateViewController

- (void)viewDidLoad{
  
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
    [self getNowDateFromatAnDate:[NSDate date]];
}
#pragma mark - 时间创建
-(void)dateNormal
{
    //当前UTC时间
    NSDate* date1 = [NSDate date];
    NSLog(@"UTC new:%@",date1);
    
    //现在起30秒后的时间
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:30];
    NSLog(@"dat2:%@",date2);
    
    //明天此时此刻
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    NSLog(@"date3:%@",date3);
    
    //昨天此时此刻
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    NSLog(@"date4:%@",date4);
    
    //过去随机一个时间
    NSDate* date5 = [NSDate distantPast];
    NSLog(@"date5:%@",date5);
    
    //未来随机一个时间
    NSDate* date6 = [NSDate distantFuture];
    NSLog(@"date6:%@",date6);
    
    //1970距今的秒数
    NSDate* date7 = [NSDate date];
    NSTimeInterval interval = [date7 timeIntervalSince1970];
    NSLog(@"Interval:%g",interval);
    
    
}

#pragma mark - 时间比较
-(void)dateCompare
{
    NSDate* date5 = [NSDate distantPast];
    NSDate* date6 = [NSDate distantFuture];
    
    //比较两个时间得到一个更早的时间
    NSDate* date8 = [date5 earlierDate:date6];
    NSLog(@"date8:%@",date8);
    
    //比较两个时间得到一个更晚的时间
    NSDate* date9 = [date5 laterDate:date6];
    NSLog(@"date9:%@",date9);
    
    //比较两个时间
    BOOL b = [date5 isEqualToDate:date6];
    NSLog(@"b:%d",b);
}

#pragma mark - 时间转换
-(void)dateFormatter
{
    //日期模板转换：yyyy-MM-dd 年月日 hh:mm:ss 时分秒 HH为24小时制，hh为12小时制
    NSDate* date1 = [NSDate date];
    NSDateFormatter* dateFormat = [NSDateFormatter new];//创建时间模板对象
    dateFormat.dateFormat = @"日期：yyyy-MM-dd 时间：hh:mm:ss";//设置时间模板
    NSString* strDate = [dateFormat stringFromDate:date1];//按照时间模板将某个日期进行转换
    NSLog(@"today:%@",strDate);
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [dateFormat dateFromString:@"2010-08-04 16:01:03"];
    NSLog(@"date2:%@",date2);
}

#pragma mark - 获取当前时区的时间
-(void)dateZoneNow
{
    //当前时区的时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"%@", localeDate);
    
    //时间戳
    NSTimeInterval li = [localeDate timeIntervalSince1970];
    long long lii = li*1000000;
    NSLog(@"%lld",lii);
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

-(void)test
{
//    NSString* timeStr = @"2011-01-26 17:40:50";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//
//    //设置时区,这个对于时间的处理有时很重要
//    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
//    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
//    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
//    
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
//    [formatter setTimeZone:timeZone];
//
//    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
//    
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    
//    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
//    时间转时间戳的方法:
//    NSString *timeSp = [NSString stringWithFormat:@"%d", (long)[datenow timeIntervalSince1970]];
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
//    时间戳转时间的方法
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1296035591];
//    NSLog(@"1296035591  = %@",confromTimesp);
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    NSLog(@"confromTimespStr =  %@",confromTimespStr);
//    时间戳转时间的方法:
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyyMMddHHMMss"];
//    NSDate *date = [formatter dateFromString:@"1283376197"];
//    NSLog(@"date1:%@",date);

}

//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
-(NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
-(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}


@end
