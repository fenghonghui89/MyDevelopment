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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self dateNormal];
}

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
    
    //比较两个时间得到一个更早的时间
    NSDate* date8 = [date7 earlierDate:date5];
    NSLog(@"date8:%@",date8);
    
    //比较两个时间得到一个更早的时间
    NSDate* date9 = [date7 laterDate:date5];
    NSLog(@"date9:%@",date9);
    
    //将当前UTC时间转换为本地当前时间
    //参照日期模板转换：yyyy-MM-dd 年月日 hh:mm:ss 时分秒 HH为24小时制，hh为12小时制
    NSDateFormatter* dateFormat = [NSDateFormatter new];//创建时间模板对象
    dateFormat.dateFormat = @"日期：yyyy-MM-dd 时间：hh:mm:ss";//设置时间模板
    NSString* strDate = [dateFormat stringFromDate:date1];//按照时间模板将某个日期进行转换
    NSLog(@"today:%@",strDate);
    
    //本地时间的昨天此时此刻
    NSDateFormatter* dateFormat1 = [NSDateFormatter new];
    dateFormat1.dateFormat = @"日期：yyyy-MM-dd 时间：HH:mm:ss";
    NSString* strDate1 = [dateFormat stringFromDate:date4];
    NSLog(@"yesterday:%@",strDate1);
    
    //本地时间的明天此时此刻
    NSDateFormatter* dateFormat2 = [NSDateFormatter new];
    dateFormat2.dateFormat = @"日期：dd-MM-yyyy 时间：HH:mm:ss";
    NSString* strDate2 = [dateFormat stringFromDate:date3];
    NSLog(@"tomorrow:%@",strDate2);
}


@end
