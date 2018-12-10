//
//  UserInfo_mo.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-28.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Setting_mo;

@interface UserInfo_mo : NSManagedObject

@property (nonatomic, retain) NSString * access_token;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) Setting_mo *setting_mo;

@end
