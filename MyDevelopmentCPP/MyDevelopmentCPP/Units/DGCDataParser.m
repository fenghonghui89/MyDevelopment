//
//  DGCDataParser.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/12/24.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCDataParser.h"

@interface DGCDataParser()
@end
@implementation DGCDataParser
+(NSInteger)parseIntData:(NSDictionary *)data key:(NSString *)key
{
  NSAssert([data isKindOfClass:[NSDictionary class]], @"数据类型不符合");
  id tmp = [data objectForKey:key];
  
  if (tmp == nil || tmp == NULL || [tmp isEqual:[NSNull null]]) {
    return 0;
  }else{
    return [tmp integerValue];
  }
}

+(CGFloat)parseFloatData:(NSDictionary *)data key:(NSString *)key
{
  NSAssert([data isKindOfClass:[NSDictionary class]], @"数据类型不符合");
  id tmp = [data objectForKey:key];

  if (tmp == nil || tmp == NULL || [tmp isEqual:[NSNull null]]) {
    return .0;
  }else{
    return [tmp floatValue];
  }
}

+(NSString *)parseStrData:(NSDictionary *)data key:(NSString *)key
{
  NSAssert([data isKindOfClass:[NSDictionary class]], @"数据类型不符合");
  NSString *tmp = [data objectForKey:key];
  
  if (tmp == nil || tmp == NULL || [tmp isEqual:[NSNull null]]) {
    return @"";
  }else{
    return tmp;
  }
}

+(NSArray *)parseArrayData:(NSDictionary *)data key:(NSString *)key
{
  NSAssert([data isKindOfClass:[NSDictionary class]], @"数据类型不符合");
  NSArray *tmp = [data objectForKey:key];
  
  if (tmp == nil || tmp == NULL || [tmp isEqual:[NSNull null]]) {
    return nil;
  }else{
    return tmp;
  }
}

+(NSDictionary *)parseDicData:(NSDictionary *)data key:(NSString *)key
{
  NSAssert([data isKindOfClass:[NSDictionary class]], @"数据类型不符合");
  NSDictionary *dic = [data objectForKey:key];
  if (data == nil || data == NULL || [data isEqual:[NSNull null]]) {
    return nil;
  }else{
    return dic;
  }
}

@end
