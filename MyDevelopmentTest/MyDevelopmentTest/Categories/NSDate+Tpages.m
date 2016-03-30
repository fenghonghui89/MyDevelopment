//
//  Utils.m
//  TpagesSNS
//
//  Created by Jackey Cheung on 2015-10-30.
//  Copyright © 2015 NearKong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate+Tpages.h"


@implementation NSDate(Tpages)

+(NSDate *)fromServerDateTimeString:(NSString*)datetime
{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:DATETIME_FORMAT];
  [df setTimeZone:[NSTimeZone timeZoneWithName:SERVER_TIMEZONE]];
  return [df dateFromString:datetime];
}

-(NSString *)toLocalDateTimeString
{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:DATETIME_FORMAT];
  return [df stringFromDate:self];
}

-(NSString *)toServerDateTimeString
{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setTimeZone:[NSTimeZone timeZoneWithName:SERVER_TIMEZONE]];
  [df setDateFormat:DATETIME_FORMAT];
  return [df stringFromDate:self];
}

@end