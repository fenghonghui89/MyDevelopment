//
//  DGCDataParser.h
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/12/24.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DGCDataParser : NSObject

+(NSInteger)parseIntData:(NSDictionary *)data key:(NSString *)key;
+(CGFloat)parseFloatData:(NSDictionary *)data key:(NSString *)key;
+(NSString *)parseStrData:(NSDictionary *)data key:(NSString *)key;
+(NSArray *)parseArrayData:(NSDictionary *)data key:(NSString *)key;
+(NSDictionary *)parseDicData:(NSDictionary *)data key:(NSString *)key;
@end
