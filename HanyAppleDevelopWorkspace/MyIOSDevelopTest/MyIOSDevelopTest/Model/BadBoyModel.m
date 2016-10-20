//
//  BadBoyModel.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/20.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "BadBoyModel.h"
#import <objc/runtime.h>
@implementation BadBoyModel

#pragma mark 输出所有属性和值
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
      
      //NSInvocation调用方法
      NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
      NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
      [invocation setTarget:self];
      [invocation setSelector:getSel];
      
      //接收返回的值
      NSObject *__unsafe_unretained returnValue = nil;
      [invocation invoke];
      [invocation getReturnValue:&returnValue];
      
      [resultString appendFormat:@"%@\n", returnValue];
    }
  }
  NSLog(@"%@", resultString);
  
}


#pragma mark 根据映射关系来给Model的属性赋值
-(NSDictionary *) propertyMapDic{
  
  //返回数据:实体属性
  return @{@"netName":@"name",
           @"netAge":@"age"};
}

-(void)assginToPropertyWithNoMapDictionary:(NSDictionary *)data{
  
  //获取字典和Model属性的映射关系
  NSDictionary *propertyMapDic = [self propertyMapDic];
  
  //转化成key和property一样的字典
  NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:[data allKeys].count];
  for (int i = 0; i < [data allKeys].count; i ++) {
    NSString *key = [data allKeys][i];
    [tempDic setObject:data[key] forKey:propertyMapDic[key]];
  }
  
  //字典转模型
//  [self assginToPropertyWithDictionary:tempDic];
  [self setValuesForKeysWithDictionary:tempDic];
  
}


-(void)assginToPropertyWithDictionary:(NSDictionary *)data{

  [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    [self setValue:obj forKeyPath:key];
  }];
}

-(instancetype)initWithDictionary:(NSDictionary *)data{
  self = [super init];
  if (self) {
    if ([self propertyMapDic] == nil) {
      [self assginToPropertyWithDictionary:data];
    } else {
      [self assginToPropertyWithNoMapDictionary:data];
    }
  }
  return self;
}
@end
