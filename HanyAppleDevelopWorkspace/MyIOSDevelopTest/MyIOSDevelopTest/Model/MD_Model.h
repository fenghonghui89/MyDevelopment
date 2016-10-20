//
//  MD_Runtime_Model.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 runtime
 */

#import <Foundation/Foundation.h>
#import "MDRootDefine.h"
#import "MD_BaseModel.h"

@interface MDCityWeather : MD_BaseModel

PROPERTY_NON_ATOMIC_ASSIGN NSInteger error_code;//返回码
PROPERTY_NON_ATOMIC_COPY NSString *reason;//返回说明
PROPERTY_NON_ATOMIC_COPY NSString *date;
PROPERTY_NON_ATOMIC_ASSIGN BOOL isForeign;

//realtime
PROPERTY_NON_ATOMIC_COPY NSString *realtime_city_code;//城市id
PROPERTY_NON_ATOMIC_COPY NSString *realtime_city_name;//日期
PROPERTY_NON_ATOMIC_COPY NSString *realtime_date;//更新时间
PROPERTY_NON_ATOMIC_COPY NSString *realtime_time;
PROPERTY_NON_ATOMIC_COPY NSString *realtime_week;
PROPERTY_NON_ATOMIC_COPY NSString *realtime_moon;
PROPERTY_NON_ATOMIC_COPY NSString *realtime_dataUptime;

PROPERTY_NON_ATOMIC_COPY NSString *realtime_weather_temperature;//温度
PROPERTY_NON_ATOMIC_COPY NSString *realtime_weather_humidity;//湿度
PROPERTY_NON_ATOMIC_COPY NSString *realtime_weather_info;
PROPERTY_NON_ATOMIC_COPY NSString *realtime_weather_img;//对应的图片id

PROPERTY_NON_ATOMIC_COPY NSString *realtime_wind_direct;//风向
PROPERTY_NON_ATOMIC_COPY NSString *realtime_wind_power;//级别
PROPERTY_NON_ATOMIC_COPY NSString *realtime_wind_offset;
PROPERTY_NON_ATOMIC_COPY NSString *realtime_wind_windspeed;//风速

//life 生活指数
PROPERTY_NON_ATOMIC_COPY NSString *life_date;
PROPERTY_NON_ATOMIC_COPY NSString *life_info_chuanyi;//穿衣指数
PROPERTY_NON_ATOMIC_COPY NSString *life_info_ganmao;//感冒指数
PROPERTY_NON_ATOMIC_COPY NSString *life_info_kongtiao;//空调指数
PROPERTY_NON_ATOMIC_COPY NSString *life_info_wuran;//污染指数
PROPERTY_NON_ATOMIC_COPY NSString *life_info_xiche;//洗车指数
PROPERTY_NON_ATOMIC_COPY NSString *life_info_yundong;//运动指数
PROPERTY_NON_ATOMIC_COPY NSString *life_info_ziwaxian;//紫外线


//weather 未来几天天气预报
PROPERTY_NON_ATOMIC_STRONG NSArray *weather;


//pm25
PROPERTY_NON_ATOMIC_COPY NSString *key;
PROPERTY_NON_ATOMIC_COPY NSString *show_desc;
PROPERTY_NON_ATOMIC_COPY NSString *pm25_curPm;
PROPERTY_NON_ATOMIC_COPY NSString *pm25_pm25;
PROPERTY_NON_ATOMIC_COPY NSString *pm25_pm10;
PROPERTY_NON_ATOMIC_COPY NSString *pm25_level;
PROPERTY_NON_ATOMIC_COPY NSString *pm25_quality;//质量
PROPERTY_NON_ATOMIC_COPY NSString *pm25_des;//描述
PROPERTY_NON_ATOMIC_COPY NSString *dateTime;//时间
PROPERTY_NON_ATOMIC_COPY NSString *cityName;//城市名

@end




@class TRPoint;
@interface MDWeather : MD_BaseModel

PROPERTY_NON_ATOMIC_COPY NSString *date;
PROPERTY_NON_ATOMIC_COPY NSString *week;
PROPERTY_NON_ATOMIC_COPY NSString *nongli;
PROPERTY_NON_ATOMIC_STRONG NSArray *info_day;//白天天气：天气id、天气、高温、风向、风力
PROPERTY_NON_ATOMIC_STRONG NSArray *info_night;//夜间天气
PROPERTY_NON_ATOMIC_STRONG TRPoint *point;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger testIntValue;
+(MDWeather *)parseByData:(NSDictionary *)data;
@end





@interface TRPoint : NSObject

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

@end


@interface TRXYZ : TRPoint

@property(nonatomic,assign)int z;

@end




