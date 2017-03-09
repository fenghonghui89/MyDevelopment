//
//  MDNotificationManager.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDPushNotificationManager : NSObject

+(MDPushNotificationManager *)sharedInstance;

-(void)start;

-(void)cancleAllNotifications;


@end
