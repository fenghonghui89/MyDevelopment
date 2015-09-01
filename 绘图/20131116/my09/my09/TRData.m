//
//  TRData.m
//  my09
//
//  Created by HanyFeng on 13-11-17.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRData.h"

@implementation TRData


+(NSArray*)demoData
{
    TRData* data1 = [TRData new];
    data1.color = [UIColor redColor];
    data1.value = 0.2;
    
    TRData* data2 = [TRData new];
    data2.color = [UIColor greenColor];
    data2.value = 0.4;
    
    TRData* data3 = [TRData new];
    data3.color = [UIColor blueColor];
    data3.value = 0.3;
    
    return @[data1,data2,data3];
}
@end
