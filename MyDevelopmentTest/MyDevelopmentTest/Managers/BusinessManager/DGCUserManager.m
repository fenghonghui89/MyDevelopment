//
//  DGCUserManager.m
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import "DGCUserManager.h"

#import "DGCServerCallBackDelegate.h"
#import "DGCDelegateInfo.h"
#import "MDTool.h"

#import "DGCLoginServices.h"
@interface DGCUserManager()<DGCServerCallBackDelegate>
@end
@implementation DGCUserManager
+(DGCUserManager *)share
{
    static DGCUserManager *share = nil;
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
 *  @param userinfo     自定义信息
 *  @param delegate     代理
 */
-(void)loginByUsername:(NSString *)username
              password:(NSString *)password
              sysmodel:(NSInteger)sysmodel
              userinfo:(NSDictionary *)userinfo
              delegate:(id<DGCUserManagerDelegate>)degelate
{
    DGCDelegateInfo *accountDelegate = [DGCDelegateInfo new];
    accountDelegate.delegate = degelate;
    accountDelegate.code = DGCRequestCodeLogin;
    accountDelegate.info = userinfo;
    
    [[DGCLoginServices share] loginByUsername:username
                                     password:password
                                     sysmodel:sysmodel
                                     userinfo:[NSDictionary dictionaryWithObject:accountDelegate forKey:DGC_DELEGATE_INFO_KEY]
                                     delegate:self];
}

-(void)DGCServicesSuccess:(DGCBaseModel *)data errorCode:(DGCRequestErrorCode)code msg:(NSString *)msg userInfo:(NSDictionary *)userInfo
{
    DGCDelegateInfo *delegateInfo = [userInfo objectForKey:DGC_DELEGATE_INFO_KEY];
    id delegate = delegateInfo.delegate;
    switch (delegateInfo.code) {
        case DGCRequestCodeLogin:
            [self callBackBySingLogin:delegate isSuccess:YES data:(DGCUserInfo *)data errorCode:DGCRequestErrorCodeSuccess msg:msg userInfo:delegateInfo.info];
            break;
            
        default:
            break;
    }
}

-(void)DGCServicesFailer:(DGCBaseModel *)data errorCode:(DGCRequestErrorCode)code msg:(NSString *)msg userInfo:(NSDictionary *)userInfo
{
    DGCDelegateInfo *delegateInfo = [userInfo objectForKey:DGC_DELEGATE_INFO_KEY];
    id delegate = delegateInfo.delegate;
    switch (delegateInfo.code) {
        case DGCRequestCodeLogin:
            [self callBackBySingLogin:delegate isSuccess:NO data:nil errorCode:code msg:msg userInfo:delegateInfo.info];
            break;
            
        default:
            break;
    }
}

#pragma mark - callback -
- (void)callBackBySingLogin:(id)delegate
                    isSuccess:(BOOL)isSuccess
                    data:(DGCUserInfo *)data
                         errorCode:(DGCRequestErrorCode)code
                               msg:(NSString *)msg
                          userInfo:(NSDictionary *)userInfo
{
    if ([MDTool cureentThreadIsMain]) {
        if ([delegate respondsToSelector:@selector(DGCLogin:isSuccess:data:errorCode:msg:userInfo:)]) {
            [delegate DGCLogin:self isSuccess:isSuccess data:data errorCode:code msg:msg userInfo:userInfo];
        }
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([delegate respondsToSelector:@selector(DGCLogin:isSuccess:data:errorCode:msg:userInfo:)]) {
                [delegate DGCLogin:self isSuccess:isSuccess data:data errorCode:code msg:msg userInfo:userInfo];
            }
        });
    }
}

@end
