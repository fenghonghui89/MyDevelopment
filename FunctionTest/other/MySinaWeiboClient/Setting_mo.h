//
//  Setting_mo.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-28.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserInfo_mo;

@interface Setting_mo : NSManagedObject

@property (nonatomic, retain) NSNumber * isFirstRun;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * skin;
@property (nonatomic, retain) NSSet *userInfos_mo;
@end

@interface Setting_mo (CoreDataGeneratedAccessors)

- (void)addUserInfos_moObject:(UserInfo_mo *)value;
- (void)removeUserInfos_moObject:(UserInfo_mo *)value;
- (void)addUserInfos_mo:(NSSet *)values;
- (void)removeUserInfos_mo:(NSSet *)values;

@end
