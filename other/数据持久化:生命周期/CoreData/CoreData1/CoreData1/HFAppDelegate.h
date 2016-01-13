//
//  HFAppDelegate.h
//  CoreData1
//
//  Created by hanyfeng on 14-5-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//
//CoreData-系统模板代码解读
#import <UIKit/UIKit.h>

@interface HFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
