//
//  MDWeather.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/17.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 PROPERTY_NON_ATOMIC_COPY NSString *date;
 PROPERTY_NON_ATOMIC_COPY NSString *week;
 PROPERTY_NON_ATOMIC_COPY NSString *nongli;
 PROPERTY_NON_ATOMIC_ASSIGN NSArray *info_day;//白天天气：天气id、天气、高温、风向、风力
 PROPERTY_NON_ATOMIC_ASSIGN NSArray *info_night;//夜间天气
 */

#import "MDWeather.h"
#import "DGCDataParser.h"
@implementation MDWeather

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

  self = [super init];
  if (self) {
    _date = [aDecoder decodeObjectForKey:@"date"];
    _week = [aDecoder decodeObjectForKey:@"week"];
    _nongli = [aDecoder decodeObjectForKey:@"nongli"];
    _info_day = [aDecoder decodeObjectForKey:@"day"];
    _info_night = [aDecoder decodeObjectForKey:@"night"];
  }
  return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

  [aCoder encodeObject:_date forKey:@"date"];
  [aCoder encodeObject:_week forKey:@"week"];
  [aCoder encodeObject:_nongli forKey:@"nongli"];
  [aCoder encodeObject:_info_day forKey:@"day"];
  [aCoder encodeObject:_info_night forKey:@"night"];
}

+(MDWeather *)parseByData:(NSDictionary *)data{
  
  MDWeather *weather = [MDWeather new];
  
  weather.date = [DGCDataParser parseStrData:data key:@"date"];
  weather.week = [DGCDataParser parseStrData:data key:@""];
  weather.nongli = [DGCDataParser parseStrData:data key:@""];
  
  NSDictionary *info = [DGCDataParser parseDicData:data key:@"info"];
  weather.info_day = [DGCDataParser parseArrayData:info key:@"day"];
  weather.info_night = [DGCDataParser parseArrayData:info key:@"night"];
  
  return weather;
}

@end
