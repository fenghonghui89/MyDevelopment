//
//  CoreDataNoteManager.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-15.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Setting.h"
#import "UserInfo.h"
#import "Setting_mo.h"
#import "UserInfo_mo.h"

@interface CoreDataSettingManager : NSObject
//被管理的对象上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//被管理的对象模型-xxx.xcdatamodeld
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储协调者
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain) Setting *setting;

+(CoreDataSettingManager *)shareManager;
-(id)findSettingWithOption:(NSString *)option;
-(void)changeSettingWithOption:(NSString *)option andValue:(id)value;
@end
