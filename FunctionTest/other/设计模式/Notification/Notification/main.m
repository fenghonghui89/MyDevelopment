//
//  main.m
//  Notification
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meeting.h"
#import "Fans.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Meeting *meeting = [Meeting new];
        Fans *fans = [Fans new];
        
        [fans removeObserver];
        [meeting sendMessage];
        
    }
    return 0;
}

