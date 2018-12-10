//
//  HFData.m
//  TableViewFold
//
//  Created by hanyfeng on 14-4-10.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFData.h"

@implementation HFData
+(NSMutableArray*)data{
    
    NSString *str1he = @"111111111";
    NSString *str1co = @"222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222wwwwww";
    NSMutableDictionary *mdic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:str1he,@"header",str1co,@"content", nil];
    
    NSString *str2he = @"222222222";
    NSString *str2co = @"222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222wwwwww";
    NSMutableDictionary *mdic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:str2he,@"header",str2co,@"content", nil];
    
    NSString *str3he = @"333333333";
    NSString *str3co = @"333333333";
    NSMutableDictionary *mdic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:str3he,@"header",str3co,@"content", nil];
    
    NSString *str4he = @"444444444";
    NSString *str4co = @"444444444";
    NSMutableDictionary *mdic4= [NSMutableDictionary dictionaryWithObjectsAndKeys:str4he,@"header",str4co,@"content", nil];
    
    NSString *str5he = @"555555555";
    NSString *str5co = @"555555555";
    NSMutableDictionary *mdic5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:str5he,@"header",str5co,@"content", nil];
    
    NSMutableArray *marr = [NSMutableArray arrayWithObjects:mdic1,mdic2,mdic3,mdic4,mdic5, nil];
    return marr;
}
@end
