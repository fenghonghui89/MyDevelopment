//
//  CoreDataNoteManager.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-15.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "CoreDataSettingManager.h"

@implementation CoreDataSettingManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Core Data stack CoreData堆栈

-(void)dealloc
{
    [_managedObjectContext release];
    _managedObjectContext = nil;
    [_persistentStoreCoordinator release];
    _persistentStoreCoordinator = nil;
    [_managedObjectModel release];
    _managedObjectModel = nil;
    
    [super dealloc];
}

static CoreDataSettingManager *shareManager = nil;
+(CoreDataSettingManager *)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc] init];
        [shareManager managedObjectContext];
        [shareManager createFirst];
    });
    return shareManager;
}

#pragma mark -3.返回被管理对象上下文（不存在则创建）
- (NSManagedObjectContext *)managedObjectContext
{
    //如果存在，直接返回
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    //如果不存在，则先获得持久化存储协调器A
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    //如果持久化存储协调器A存在，则创建被管理对象上下文对象，然后设置他的持久化存储协调器为A
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    //返回被管理对象上下文对象
    return _managedObjectContext;
}


#pragma mark -2.返回持久化存储协调器（不存在则创建）
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    //如果存在，则直接返回
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    //如果不存在，则获取Document目录下sqlite文件的URL，创建持久化存储协调器（initWit被管理对象模型）
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Setting.sqlite"];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    //为持久化存储协调器添加新的持久化数据存储
    //三种存储类型：SQLite、二进制文件、内存形式
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark -1.2返回被管理对象模型（不存在则创建）
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    //.xcdatamodeld会以NSManagedObjectModel的实例形式存在于内存中
    //因为.xcdatamodeld编译发布时会变成.momd，所以下面的参数是momd
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Setting" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

#pragma mark -1.1返回Document目录，返回类型URL
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - setting

-(void)createSetting_moWithSetting:(Setting *)paramSetting
{
    Setting_mo *setting_mo = [self findSetting_moWithSetting:paramSetting];
    
    if (setting_mo == nil) {
        setting_mo = [NSEntityDescription insertNewObjectForEntityForName:@"Setting_mo" inManagedObjectContext:self.managedObjectContext];
        setting_mo.name = paramSetting.name;
        setting_mo.isFirstRun = paramSetting.isFirstRun;
        setting_mo.skin = paramSetting.skin;
    }
    
    [self saveContext];
}

-(void)deleteSetting_moWithSetting:(Setting *)paramSetting
{
    Setting_mo *setting_mo = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Setting_mo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",paramSetting.name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *settings_mo = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert(!error, @"error:%@",[error localizedDescription]);
    if (settings_mo && settings_mo.count >0) {
        setting_mo = [settings_mo lastObject];
        [self.managedObjectContext deleteObject:setting_mo];
    }

    [self saveContext];
}

-(void)changeSettingWithOldSetting:(Setting *)paramOldSetting andNewSetting:(Setting *)paramNewSetting
{
    Setting_mo *setting_mo = [self findSetting_moWithSetting:paramOldSetting];
    
    if (setting_mo != nil) {
        setting_mo.name = paramNewSetting.name;
        setting_mo.isFirstRun = paramNewSetting.isFirstRun;
        setting_mo.skin = paramNewSetting.skin;
    }
    
    [self saveContext];
}

-(Setting_mo *)findSetting_moWithSetting:(Setting *)paramSetting
{
    Setting_mo *setting_mo = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Setting_mo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",paramSetting.name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *settings_mo = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert(!error, @"error:%@",[error localizedDescription]);
    if (settings_mo && settings_mo.count >0) {
        setting_mo = [settings_mo lastObject];
    }
    
    return setting_mo;
}

-(NSArray *)findAllSetting
{
    NSMutableArray *settings = [NSMutableArray array];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Setting_mo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *settings_mo = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert(!error, @"error:%@",[error localizedDescription]);
    if (settings_mo && settings_mo.count >0) {
        for (Setting_mo *setting_mo in settings_mo) {
            Setting *setting = [[Setting alloc] init];
            setting.name = setting_mo.name;
            setting.isFirstRun = setting_mo.isFirstRun;
            setting.skin = setting_mo.skin;
            [settings addObject:setting];
            [setting release];
        }
    }
    return settings;
}

#pragma mark - userInfo crud
-(void)createUserInfo_moWithUserInfo:(UserInfo *)paramUserInfo
{
    UserInfo_mo *userInfo_mo = [self findUserInfo_moWithUserInfo:paramUserInfo];
    if (userInfo_mo == nil) {
        userInfo_mo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo_mo" inManagedObjectContext:self.managedObjectContext];
        userInfo_mo.access_token = paramUserInfo.access_token;
        userInfo_mo.uid = paramUserInfo.uid;
        userInfo_mo.setting_mo = [self findSetting_moWithSetting:paramUserInfo.setting];
    }
    [self saveContext];
}

-(void)deleteUserInfo_moWithUserInfo:(UserInfo *)paramUserInfo
{
    UserInfo_mo *userInfo_mo = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInfo_mo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@",paramUserInfo.uid];
    [fetchRequest setPredicate:predicate];
    
    
    NSError *error = nil;
    NSArray *userInfos_mo = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert(!error, @"error:%@",[error localizedDescription]);
    if (userInfos_mo && userInfos_mo.count >0) {
        userInfo_mo = [userInfos_mo lastObject];
        [self.managedObjectContext deleteObject:userInfo_mo];
    }
    
    [self saveContext];
}

-(void)changeUserInfo_moWithOldUserInfo:(UserInfo *)paramOldUserInfo andNewUserInfo:(UserInfo *)paramNewUserInfo
{
    UserInfo_mo *userInfo_mo = [self findUserInfo_moWithUserInfo:paramOldUserInfo];
    if (userInfo_mo != nil) {
        userInfo_mo.access_token = paramNewUserInfo.access_token;
        userInfo_mo.uid = paramNewUserInfo.uid;
        userInfo_mo.setting_mo = [self findSetting_moWithSetting:paramNewUserInfo.setting];
    }
    [self saveContext];
}

-(UserInfo_mo *)findUserInfo_moWithUserInfo:(UserInfo *)paramUserInfo
{
    Setting *setting = [[Setting alloc] init];
    setting.name = @"mainSetting";
    UserInfo *userInfo = paramUserInfo;
    userInfo.setting = setting;
    [setting release];
    
    UserInfo_mo *userInfo_mo = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInfo_mo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"setting_mo == %@",[self findSetting_moWithSetting:userInfo.setting]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *userInfos_mo = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert(!error, @"error = %@",[error localizedDescription]);
    if (userInfos_mo && userInfos_mo.count > 0) {
        userInfo_mo = [userInfos_mo lastObject];
    }
    
    return userInfo_mo;
}

-(NSArray *)findAllUserInfo_moWithSetting:(Setting *)paramSetting
{
    NSMutableArray *userInfos = [NSMutableArray array];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInfo_mo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"uid" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    
    NSError *error = nil;
    NSArray *userInfos_mo = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert(!error, @"error:%@",[error localizedDescription]);
    if (userInfos_mo && userInfos_mo.count >0) {
        for (UserInfo_mo *userInfo_mo in userInfos_mo) {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.access_token = userInfo_mo.access_token;
            userInfo.uid = userInfo_mo.uid;
            userInfo.setting  = paramSetting;
            [userInfos addObject:userInfo];
            [userInfo release];
        }
    }
    return userInfos;
}

#pragma mark - 公开接口
-(void)createFirst
{
    Setting *setting = [[Setting alloc] init];
    setting.name = @"mainSetting";
    setting.isFirstRun = [NSNumber numberWithBool:YES];
    setting.skin = @"default";
    [self createSetting_moWithSetting:setting];
    [setting release];
}

-(id)findSettingWithOption:(NSString *)option
{
    if ([option isEqualToString:@"isFirstRun"]) {
        Setting *setting = [[Setting alloc] init];
        setting.name = @"mainSetting";
        Setting_mo *setting_mo = [self findSetting_moWithSetting:setting];
        [setting release];
        return setting_mo.isFirstRun;
    }
    
    if ([option isEqualToString:@"skin"]) {
        Setting *setting = [[Setting alloc] init];
        setting.name = @"mainSetting";
        Setting_mo *setting_mo = [self findSetting_moWithSetting:setting];
        [setting release];
        return setting_mo.skin;
    }
    
    if ([option isEqualToString:@"userInfo"]) {
        Setting *setting = [[Setting alloc] init];
        setting.name = @"mainSetting";
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.setting = setting;
        UserInfo_mo *userInfo_mo = [self findUserInfo_moWithUserInfo:userInfo];
        if (userInfo_mo != nil) {
            userInfo.access_token = userInfo_mo.access_token;
            userInfo.uid = userInfo_mo.uid;
            userInfo.setting = setting;
            [setting release];
            return [userInfo autorelease];
        }else{//第一次运行，但没有登录
            return nil;
        }
    }
    
    return nil;
}

-(void)changeSettingWithOption:(NSString *)option andValue:(id)value
{
    if ([option isEqualToString:@"isFirstRun"]) {
        Setting *setting = [[Setting alloc] init];
        setting.name = @"mainSetting";
        
        Setting_mo *setting_mo = [self findSetting_moWithSetting:setting];
        [setting release];
        setting_mo.isFirstRun = (NSNumber *)value;
    }
    
    if ([option isEqualToString:@"skin"]) {
        Setting *setting = [[Setting alloc] init];
        setting.name = @"mainSetting";
        
        Setting_mo *setting_mo = [self findSetting_moWithSetting:setting];
        [setting release];
        setting_mo.skin = (NSString *)value;
    }
    
    if ([option isEqualToString:@"userInfo"]) {
        
        Setting *setting = [[Setting alloc] init];
        setting.name = @"mainSetting";
        UserInfo *userInfo = (UserInfo *)value;
        userInfo.setting = setting;
        [setting release];
        
        UserInfo_mo *userInfo_mo = [self findUserInfo_moWithUserInfo:userInfo];
        if (userInfo_mo == nil) {
            [self createUserInfo_moWithUserInfo:userInfo];
        }else{
            userInfo_mo.access_token = userInfo.access_token;
            userInfo_mo.uid = userInfo.uid;
        }
    }
    
    [self saveContext];
}
@end
