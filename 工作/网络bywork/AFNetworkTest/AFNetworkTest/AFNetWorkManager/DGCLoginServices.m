//
//  DGCLoginServices.m
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import "DGCLoginServices.h"
#import "AFNetworkManager.h"
@interface DGCLoginServices()
@property(nonatomic,strong)AFNetworkManager *afNetworkManager;
@end

@implementation DGCLoginServices
/**
 *  单例模式
 *
 *  @return 单例实例
 */
+ (instancetype)share
{
    static DGCLoginServices *share = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

-(id)init
{
    self = [super init];
    if (self) {
        _afNetworkManager = [AFNetworkManager share];
    }
    return self;
}

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
              delegate:(id<DGCServerCallBackDelegate>)degelate
{
    [_afNetworkManager loginByUsername:username
                              password:password
                              sysmodel:sysmodel
                              userinfo:userinfo
                              delegate:degelate];
}
@end
