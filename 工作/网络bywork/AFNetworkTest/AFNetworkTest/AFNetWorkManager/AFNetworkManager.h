//
//  AFNetworkManager.h
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//




#import <Foundation/Foundation.h>

#import "DGCDefine.h"
#import "DGCBaseModel.h"
#import "DGCServerCallBackDelegate.h"

@interface AFNetworkManager : NSObject

+(AFNetworkManager *)share;
/**
 *  1.登录
 *
 *  @param username     用户名
 *  @param password     密码
 *  @param sysmodel     系统类型
 *  @param deviceId     设备id
 *  @param userinfo     自定义信息
 *  @param delegate     代理
 */
-(void)loginByUsername:(NSString *)username
              password:(NSString *)password
              sysmodel:(NSInteger)sysmodel
              userinfo:(NSDictionary *)userinfo
              delegate:(id<DGCServerCallBackDelegate>)degelate;;
@end
