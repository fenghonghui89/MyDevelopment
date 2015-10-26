//
//  AFNetworkManager.m
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworkManager.h"

#import "AFNetworking.h"

#import "DGCUserInfo.h"
#import <CommonCrypto/CommonDigest.h>
@interface AFNetworkManager()

@end
@implementation AFNetworkManager
+(AFNetworkManager *)share
{
    static AFNetworkManager *share = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

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
              delegate:(id<DGCServerCallBackDelegate>)degelate
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *requestURL = @"http://51uca.com/biz/login";
    NSString *md5_password = [self md5:password];
    NSString *md5_tmp = [md5_password stringByAppendingString:@"rickyhoxiaoyi@163.com"];
    NSString *md5_final = [self md5:md5_tmp];
    NSDictionary *paraDic = @{@"username":username,
                              @"password":md5_final,
                              @"sysModel":@(sysmodel),
                              };

    [manager POST:requestURL parameters:paraDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger errorCode = [[dic objectForKey:@"status"] integerValue];
        
        if (errorCode == DGCRequestErrorCodeSuccess) {
            DGCUserInfo *uf = [[DGCUserInfo alloc] init];
            [degelate DGCServicesSuccess:uf errorCode:DGCRequestErrorCodeSuccess msg:@"" userInfo:userinfo];
        }else{
            NSString *msg = [dic objectForKey:@"errMsg"];
            [degelate DGCServicesFailer:nil errorCode:errorCode msg:msg userInfo:userinfo];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [degelate DGCServicesFailer:nil errorCode:-100 msg:@"网络错误" userInfo:userinfo];
    }];
}


-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
