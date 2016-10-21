//
//  MD_Runtime_Model.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Model.h"
#import "YYModel.h"
#import "DGCDataParser.h"


#pragma mark - ******************* MDWeather *******************
@implementation MDWeather
-(NSString *)description{
  return [self yy_modelDescription];
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


-(void)displayCurrentModleProperty{
  
  //获取实体类的属性名
  NSMutableArray *allNames = [[NSMutableArray alloc] init];
  
  unsigned int propertyCount = 0;
  objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
  
  for (int i = 0; i < propertyCount; i ++) {
    objc_property_t property = propertys[i];
    const char *propertyName = property_getName(property);
    [allNames addObject:[NSString stringWithUTF8String:propertyName]];
  }
  
  free(propertys);
  
  //拼接参数
  NSMutableString *resultString = [[NSMutableString alloc] init];
  
  for (int i = 0; i < allNames.count; i ++) {
    
    //获取get方法
    SEL getSel = NSSelectorFromString(allNames[i]);
    
    if ([self respondsToSelector:getSel]) {
      
      //NSInvocation调用get方法
      NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
      NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
      [invocation setTarget:self];
      [invocation setSelector:getSel];
      
      //接收返回的值
      NSObject *__unsafe_unretained returnValue = nil;
      [invocation invoke];
      [invocation getReturnValue:&returnValue];
      
      [resultString appendFormat:@"displayCurrentModleProperty..%@\n", returnValue];
    }
  }
  NSLog(@"%@", resultString);
  
}
//PROPERTY_NON_ATOMIC_COPY NSString *date;
//PROPERTY_NON_ATOMIC_COPY NSString *week;
//PROPERTY_NON_ATOMIC_COPY NSString *nongli;
//PROPERTY_NON_ATOMIC_STRONG NSArray *info_day;//白天天气：天气id、天气、高温、风向、风力
//PROPERTY_NON_ATOMIC_STRONG NSArray *info_night;//夜间天气
//PROPERTY_NON_ATOMIC_STRONG TRPoint *point;
//PROPERTY_NON_ATOMIC_ASSIGN NSInteger testIntValue;
//Model 属性名和 JSON 中的 Key 不相同
+(NSDictionary *)modelCustomPropertyMapper{
  return @{@"info_day" : @"info.day",
           @"info_night" : @"info.night"};
}

@end

#pragma mark - ******************* TRPoint *******************

@implementation TRPoint

#pragma mark - < override >
#pragma mark * other
-(NSString*)description{
  
  return [self yy_modelDescription];
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
  return [self yy_modelDescription];
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



