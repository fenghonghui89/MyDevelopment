//
//  Fans.m
//  Notification
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "Fans.h"

@implementation Fans
-(id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getName:) name:@"name" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate:) name:@"date" object:nil];
    }
    return self;
}

-(void)getName:(NSNotification *)sender
{
    NSDictionary *dic = sender.userInfo;
    NSString *message = dic[@"name"];
    NSLog(@"%@：会议名称：%@",self,message);
}

-(void)getDate:(NSNotification *)sender
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [dateFormatter stringFromDate:sender.object];
    
    NSLog(@"%@：会议时间：%@",self,str);
}

-(void)removeObserver
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"date" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
