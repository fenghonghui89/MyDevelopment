//
//  MDGlobalManager.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#define ULog(format,...) do{   \
if ([MDGlobalManager sharedInstance].openLog) {NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);} \
}while(0)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MDGlobalManager : NSObject

@property(nonatomic,assign)BOOL openLog;
@property(nonatomic,assign)BOOL isOpenNotification;
@property(nonatomic,assign)BOOL hasFirstLaunch;
@property(nonatomic,assign)NSInteger count;

+(MDGlobalManager *)sharedInstance;

+(UIViewController *)getPresentedViewController;
+(UIWindow *)appDelegateWindow;

-(void)storeData:(NSDictionary *)data;
-(NSDictionary *)getStoreData;
-(void)deleteStoreData;
@end
