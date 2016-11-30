//
//  MDGlobalManager.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDGlobalManager.h"
#import "AppDelegate.h"
@implementation MDGlobalManager

@synthesize isOpenNotification = _isOpenNotification,hasFirstLaunch = _hasFirstLaunch,count = _count;

+(MDGlobalManager *)sharedInstance{

  static MDGlobalManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

#pragma mark - other
+(UIViewController *)getPresentedViewController{
  UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  UIViewController *topVC = appRootVC;
  if(topVC.presentedViewController)
  {
    topVC = topVC.presentedViewController;
  }
  
  return topVC;
}

+(UIWindow *)appDelegateWindow{
  AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  return delegate.window;
}

-(void)storeData:(NSDictionary *)data{
  
  NSData *storeData = [NSKeyedArchiver archivedDataWithRootObject:data];
  [[NSUserDefaults standardUserDefaults] setObject:storeData forKey:@"storeData"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
}

-(NSDictionary *)getStoreData{
  
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"storeData"];
  NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  return dic;
}

-(void)deleteStoreData{

  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"storeData"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - set/get
-(void)setIsOpenNotification:(BOOL)isOpenNotification{
  
  BOOL isOpenNotification_uf = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenNotification"];
  
  if (isOpenNotification != isOpenNotification_uf) {
    _isOpenNotification = isOpenNotification;
    
    [[NSUserDefaults standardUserDefaults] setBool:isOpenNotification forKey:@"isOpenNotification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
  
}

-(BOOL)isOpenNotification{
  
  BOOL isOpenNotification = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenNotification"];
  return isOpenNotification;
}

-(void)setHasFirstLaunch:(BOOL)hasFirstLaunch{

  BOOL hasFirstLaunch_uf = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasFirstLaunch"];
  
  if (hasFirstLaunch != hasFirstLaunch_uf) {
    _hasFirstLaunch = hasFirstLaunch;
    
    [[NSUserDefaults standardUserDefaults] setBool:hasFirstLaunch forKey:@"hasFirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

-(BOOL)hasFirstLaunch{
  
  BOOL hasFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasFirstLaunch"];
  return hasFirstLaunch;
}

-(void)setCount:(NSInteger)count{

  NSInteger count_uf = [[NSUserDefaults standardUserDefaults] integerForKey:@"count"];
  if (count_uf != count) {
    _count = count;
    
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"count"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

-(NSInteger)count{

  NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"count"];
  return count;
}


@end
