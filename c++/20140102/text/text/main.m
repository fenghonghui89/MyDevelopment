//
//  main.m
//  text
//
//  Created by HanyFeng on 14-1-4.
//  Copyright (c) 2014年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mydate.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Mydate* date = [[Mydate alloc] initWithYear:2014 andMon:1 andDay:1];
        [date show];
        [date addDay];
        [date show];
    }
    return 0;
}

