//
//  MD_Runtime_Model.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Model.h"

#import "DGCDataParser.h"
#import <objc/runtime.h>


#pragma mark - ******************* MDWeather *******************
@implementation MDWeather

#pragma mark - < overwrite >
+(void)initialize{
  
  DRLog(@"%@ initialize",[self class]);
}

#pragma mark - < method >
+(MDWeather *)parseByData:(NSDictionary *)data{
  
  MDWeather *weather = [MDWeather new];
  
  weather.date = [DGCDataParser parseStrData:data key:@"date"];
  weather.week = [DGCDataParser parseStrData:data key:@"week"];
  weather.nongli = [DGCDataParser parseStrData:data key:@"nongli"];
  
  NSDictionary *info = [DGCDataParser parseDicData:data key:@"info"];
  weather.info_day = [DGCDataParser parseArrayData:info key:@"day"];
  weather.info_night = [DGCDataParser parseArrayData:info key:@"night"];
  
  return weather;
}

#pragma mark - < callback >
#pragma mark * NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
  
  //  self = [super init];
  //  if (self) {
  //    _date = [aDecoder decodeObjectForKey:@"date"];
  //    _week = [aDecoder decodeObjectForKey:@"week"];
  //    _nongli = [aDecoder decodeObjectForKey:@"nongli"];
  //    _info_day = [aDecoder decodeObjectForKey:@"day"];
  //    _info_night = [aDecoder decodeObjectForKey:@"night"];
  //  }
  //  return self;
  
  
  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList([MDWeather class], &count);
  
  for (int i = 0;i < count;i ++) {
    objc_property_t property = properties[i];
    const char *name = property_getName(property);
    NSString *key = [NSString stringWithUTF8String:name];
    [self setValue:[aDecoder decodeObjectForKey:key] forKeyPath:key];//解码每个属性,利用kVC取出每个属性对应的数值
  }
  return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
  
  //  [aCoder encodeObject:_date forKey:@"date"];
  //  [aCoder encodeObject:_week forKey:@"week"];
  //  [aCoder encodeObject:_nongli forKey:@"nongli"];
  //  [aCoder encodeObject:_info_day forKey:@"day"];
  //  [aCoder encodeObject:_info_night forKey:@"night"];
  
  
  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList([MDWeather class], &count);
  
  for (int i = 0;i < count;i ++) {
    objc_property_t property = properties[i];
    const char *name = property_getName(property);
    NSString *key = [NSString stringWithUTF8String:name];
    [aCoder encodeObject:[self valueForKeyPath:key] forKey:key];//编码每个属性,利用kVC取出每个属性对应的数值
  }
}

@end

#pragma mark - ******************* TRPoint *******************

@implementation TRPoint

#pragma mark - < override >
#pragma mark * other
-(NSString*)description{
  
  return [NSString stringWithFormat:@"x:%d,y:%d",self.x,self.y];
}
#pragma mark * obj lifecycle
+(void)initialize{
  
  DRLog(@"%@ initialize",[self class]);
}

-(instancetype)init{
  
  self = [super init];
  if (self) {
    DRLog(@"%@ init",[self class]);
  }
  return self;
}

@end

#pragma mark - ******************* TRXYZ *******************
@implementation TRXYZ

#pragma mark - < override >
#pragma mark * other
-(NSString*)description{
  return [NSString stringWithFormat:@"x:%d,y:%d,z:%d",self.x,self.y,self.z];
}

#pragma mark * obj lifecycle
+(void)initialize{
  
  DRLog(@"%@ initialize",[self class]);
}

-(instancetype)init{
  
  self = [super init];
  if (self) {
    DRLog(@"%@ init",[self class]);
  }
  return self;
}
@end



