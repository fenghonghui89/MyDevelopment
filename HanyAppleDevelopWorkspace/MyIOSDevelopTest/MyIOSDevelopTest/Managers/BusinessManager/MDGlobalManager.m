//
//  MDGlobalManager.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDGlobalManager.h"

@implementation MDGlobalManager
+(MDGlobalManager *)sharedInstance{

  static MDGlobalManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}
@end
