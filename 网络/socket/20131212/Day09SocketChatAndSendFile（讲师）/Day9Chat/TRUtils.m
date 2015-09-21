//
//  TRUtils.m
//  Day9Chat
//
//  Created by Tarena on 13-12-13.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRUtils.h"

@implementation TRUtils
+(NSMutableData *)getAllDataByHeaderString:(NSString *)header{
    NSData *headerData = [header dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *allData = [NSMutableData dataWithLength:100];
    [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
    
    return allData;
    
}
@end
