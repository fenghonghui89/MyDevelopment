//
//  CoreDataMyNote.m
//  PersistenceLayer
//
//  Created by hanyfeng on 14-5-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "CoreDataNoteManager.h"

@implementation CoreDataNoteManager

//必须要写同步？？
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


#pragma mark - Core Data stack CoreData堆栈-


#pragma mark - 3.返回被管理对象上下文（不存在则创建） -
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


#pragma mark - 2.返回持久化存储协调器（不存在则创建） -
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    //如果存在，则直接返回
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    
    
    
    //如果不存在，则获取Document目录下sqlite文件的URL
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataMyNote.sqlite"];
    
    NSError *error = nil;
    
    //创建持久化存储协调器（initWit被管理对象模型）
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    //为持久化存储协调器添加新的持久化数据存储
    //三种存储类型：SQLite、二进制文件、内存形式
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - 1.2返回被管理对象模型（不存在则创建） -
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    //根据.xcdatamodeld模板创建对象模型
    //因为.xcdatamodeld编译发布时会变成.momd，所以下面的参数是momd
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataMyNote" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

#pragma mark - 1.1返回Document目录，返回类型URL
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
