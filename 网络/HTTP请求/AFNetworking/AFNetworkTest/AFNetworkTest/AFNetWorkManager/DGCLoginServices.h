//
//  DGCLoginServices.h
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGCServerCallBackDelegate.h"
@interface DGCLoginServices : NSObject
/**
 *  单例模式
 *
 *  @return 单例实例
 */
+ (instancetype)share;

/**
 *  1.登录
 *
 *  @param username     用户名
 *  @param password     密码
 *  @param sysmodel     系统类型
 *  @param userinfo     自定义信息
 *  @param delegate     代理
 */
-(void)loginByUsername:(NSString *)username
              password:(NSString *)password
              sysmodel:(NSInteger)sysmodel
              userinfo:(NSDictionary *)userinfo
              delegate:(id<DGCServerCallBackDelegate>)degelate;
@end
