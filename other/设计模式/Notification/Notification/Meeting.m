//
//  Meeting.m
//  Notification
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "Meeting.h"

@implementation Meeting

-(void)sendMessage
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"Apple Meeting" forKey:@"name"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:nil userInfo:dic];
    
    NSDate *date = [NSDate date];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"date" object:date];
}
@end
