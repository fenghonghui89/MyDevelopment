//
//  Utils.h
//  TpagesSNS
//
//  Created by Jackey Cheung on 2015-10-30.
//  Copyright © 2015 NearKong. All rights reserved.
//

#ifndef NSDate_Tpages_h
#define NSDate_Tpages_h

#define SERVER_TIMEZONE @"Asia/Hong_Kong"

#define DATETIME_FORMAT @"yyyy-MM-dd HH:mm:ss"


@interface NSDate(Tpages)

+(NSDate *)fromServerDateTimeString:(NSString*)datetime;
-(NSString *)toLocalDateTimeString;
-(NSString *)toServerDateTimeString;

@end

#endif /* NSDate_Tpages_h */
