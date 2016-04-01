//
//  UMengPushManager.h
//  UMengPush
//
//  Created by 冯鸿辉 on 16/4/1.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UMengPushManager : NSObject

+(UMengPushManager *)sharedManager;
-(void)startPush:(NSDictionary *)launchOptions;
-(void)stopPush;
- (void)registerDeviceToken:(NSData *)deviceToken;
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

-(void)addTag:(id)tag response:(void (^)(id responseObject,NSInteger remain,NSError *error))handle;
-(void)removeTag:(id)tag response:(void (^)(id responseObject,NSInteger remain,NSError *error))handle;
-(void)removeAllTag:(void (^)(id responseObject,NSInteger remain,NSError *error))handle;
-(void)getTags:(void (^)(NSSet *responseTages,NSInteger remain,NSError *error))handle;
@end
