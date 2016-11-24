//
//  MDGlobalManager.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDGlobalManager : NSObject
@property(nonatomic,assign)BOOL openLog;
@property(nonatomic,assign)BOOL isOpenNotification;
@property(nonatomic,assign)BOOL hasFirstLaunch;
+(MDGlobalManager *)sharedInstance;
@end
