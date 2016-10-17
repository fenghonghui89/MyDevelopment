//
//  MDWeather.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/17.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDRootDefine.h"
@interface MDWeather : NSObject<NSCoding>

PROPERTY_NON_ATOMIC_COPY NSString *date;
PROPERTY_NON_ATOMIC_COPY NSString *week;
PROPERTY_NON_ATOMIC_COPY NSString *nongli;
PROPERTY_NON_ATOMIC_ASSIGN NSArray *info_day;//白天天气：天气id、天气、高温、风向、风力
PROPERTY_NON_ATOMIC_ASSIGN NSArray *info_night;//夜间天气

+(MDWeather *)parseByData:(NSDictionary *)data;
@end
