//
//  Setting.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-28.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface Setting : NSObject
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSNumber *isFirstRun;
@property(nonatomic,retain)NSString *skin;
@end
