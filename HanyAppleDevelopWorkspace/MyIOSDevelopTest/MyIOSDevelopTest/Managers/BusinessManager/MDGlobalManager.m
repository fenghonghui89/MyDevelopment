//
//  MDGlobalManager.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDGlobalManager.h"

@implementation MDGlobalManager

@synthesize isOpenNotification = _isOpenNotification,hasFirstLaunch = _hasFirstLaunch;

+(MDGlobalManager *)sharedInstance{

  static MDGlobalManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}


#pragma mark set/get
-(void)setIsOpenNotification:(BOOL)isOpenNotification{
  
  BOOL isOpenNotification_uf = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenNotification"];
  
  if (isOpenNotification != isOpenNotification_uf) {
    _isOpenNotification = isOpenNotification;
    
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    [uf setBool:isOpenNotification forKey:@"isOpenNotification"];
    [uf synchronize];
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
    
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    [uf setBool:hasFirstLaunch forKey:@"hasFirstLaunch"];
    [uf synchronize];
  }
}

-(BOOL)hasFirstLaunch{
  
  BOOL hasFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasFirstLaunch"];
  return hasFirstLaunch;
}
@end
