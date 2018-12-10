//
//  UserInfo.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-28.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

@class Setting;
#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property(nonatomic,retain)NSString *access_token;
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)Setting *setting;
@end
