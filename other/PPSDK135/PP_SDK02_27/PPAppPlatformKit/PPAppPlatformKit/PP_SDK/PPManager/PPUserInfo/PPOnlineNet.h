//
//  PPOnlineNet.h
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

// ************************************ 在线统计接口 *****************************************//

#import <Foundation/Foundation.h>
#import "PPAppPlatformKit.h"
#import "PPAppPlatformKitConfig.h"

/**
 *  统计用户注册 和 统计在线心跳
 */
@interface PPOnlineNet : NSObject{
    
}
/**
 *  根据用户ID和请求地址统计用户注册
 *
 *  @param paramUserId 当前登陆用户ID
 */
-(void)ppAppOnlineRegistRequest:(u_int64_t)paramUserId;

/**
 *  根据用户ID和请求地址统计在线心跳
 *
 *  @param paramUserId 当前登陆用户ID
 */
-(void)ppAppOnlineHrateRequest:(u_int64_t)paramUserId;

@end
