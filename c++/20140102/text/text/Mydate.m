//
//  Mydate.m
//  text
//
//  Created by HanyFeng on 14-1-4.
//  Copyright (c) 2014年 Hany. All rights reserved.
//

#import "Mydate.h"

@implementation Mydate

-(id)initWithYear:(int)year andMon:(int)mon andDay:(int)day{
    if (self = [super init]) {
        self.year = year;
        self.mon = mon;
        self.day = day;
    }
    return self;
}

-(void)show{
    NSLog(@"%d-%d-%d",self.year,self.mon,self.day);
}

-(void)addDay{
    self.day++;
}
@end
