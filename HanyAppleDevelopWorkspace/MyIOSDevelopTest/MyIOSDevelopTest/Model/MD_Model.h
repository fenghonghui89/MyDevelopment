//
//  MD_Runtime_Model.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 runtime NSSet
 */

#import <Foundation/Foundation.h>
#import "MDRootDefine.h"



@interface MDWeather : NSObject<NSCoding>

PROPERTY_NON_ATOMIC_COPY NSString *date;
PROPERTY_NON_ATOMIC_COPY NSString *week;
PROPERTY_NON_ATOMIC_COPY NSString *nongli;
PROPERTY_NON_ATOMIC_STRONG NSArray *info_day;//白天天气：天气id、天气、高温、风向、风力
PROPERTY_NON_ATOMIC_STRONG NSArray *info_night;//夜间天气

+(MDWeather *)parseByData:(NSDictionary *)data;
@end





@interface TRPoint : NSObject

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

@end






@interface TRXYZ : TRPoint

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int z;

@end





@interface TRStudent : NSObject
@property(nonatomic,assign) int age;
@property(nonatomic,copy)NSString *name;
-(void)study;
+(id)studentInitWithName:(NSString*)name AndAge:(int)age;
@end
