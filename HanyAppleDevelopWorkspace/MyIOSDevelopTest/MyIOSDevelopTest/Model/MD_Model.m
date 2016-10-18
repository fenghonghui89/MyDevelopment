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
#pragma mark * NSSet唯一性
//1.重写hash方法，使对象的hash值相同
-(NSUInteger)hash{
  
  NSLog(@"执行TRPoint的hash方法%@",self);
  return self.x+self.y;
}

//2.hash一样则用isEqual比较对象的类型关系和实例变量是否一样
-(BOOL)isEqual:(id)object{
  
  NSLog(@"执行了TRPoint的isEqual方法%@",self);
  if ([object isKindOfClass:[TRPoint class]]) {//2.1先比较对象的类型关系
    TRPoint* tempPoint = object;//2.2再比较对象的实例变量的关系
    if (self.x == tempPoint.x){
      if (self.y == tempPoint.y) {
        return YES;
      }else {
        return NO;
      }
    }else {
      return NO;
    }
  }else{
    return NO;
  }
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
#pragma mark * NSSet唯一性
-(NSUInteger)hash{   NSLog(@"执行TRXYZ的hash方法%@",self);
  return self.x+self.y+self.z;
}

-(BOOL)isEqual:(id)object
{
  NSLog(@"执行TRXYZ的isEqual方法%@",self);
  if ([object isKindOfClass:[TRXYZ class]]) {
    TRXYZ* tempXYZ = object;
    if (self.x == tempXYZ.x){
      if (self.y == tempXYZ.y) {
        if (self.z == tempXYZ.z) {
          return YES;
        }else{
          return NO;
        }
      }else{
        return NO;
      }
    }else{
      return NO;
    }
  }else{
    return NO;
  }
}
@end


#pragma mark - ******************** TRStudent ********************
@implementation TRStudent

#pragma mark - < overwrite >
#pragma mark * obj lifecycle

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
  TRStudent* student = [[TRStudent alloc] initwithName:name AndAge:age];
  return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
  if (self == [super init]) {
    self.name = name;
    self.age = age;
  }
  return self;
}

#pragma mark * other
-(NSString*)description{
  
  NSLog(@"执行了description方法");
  return [NSString stringWithFormat:@"age:%d",self.age];
}

#pragma mark * NSSet hash
//1.先比较对象的hash值（重写hash方法）
-(NSUInteger)hash{
  
  return self.age;
}

//2.hash值一样则用isEqual比较对象的类型关系和值是否一样
-(BOOL)isEqual:(id)object{
  
  NSLog(@"执行了isEqual");
  if (![object isKindOfClass:[TRStudent class]]) {//2.1先比较对象的类型关系
    return YES;
  }else {
    //2.2再比较对象的值的关系
    if ([self.name isEqual:object]) {
      return YES;
    }else{
      return NO;
    }
  }
}

#pragma mark - < method >
-(void)study{
  
  NSLog(@"study~");
}
@end
