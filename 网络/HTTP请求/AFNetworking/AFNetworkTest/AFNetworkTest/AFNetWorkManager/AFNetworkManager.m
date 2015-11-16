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
#import "DGCTool.h"
#import "DGCUserInfo.h"
#import "DGCServerCallBackDelegate.h"

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
 *  @param successBlock 成功回调
 *  @param failerBlock  失败回调
 */
-(void)loginByUsername:(NSString *)username
              password:(NSString *)password
              sysmodel:(NSInteger)sysmodel
              userinfo:(NSDictionary *)userinfo
       successCallBack:(DGCServiceSuccessBlock)successBlock
        failerCallBack:(DGCServiceFailedBlock)failerBlock;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *requestURL = @"http://51uca.com/biz/login";
    NSString *md5_password = [DGCTool md5:password];
    NSString *md5_tmp = [md5_password stringByAppendingString:@"rickyhoxiaoyi@163.com"];
    NSString *md5_final = [DGCTool md5:md5_tmp];
    
    NSDictionary *paraDic = @{@"username":username,
                              @"password":md5_final,
                              @"sysModel":@(sysmodel),
                              };

    [manager POST:requestURL parameters:paraDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger errorCode = [[dic objectForKey:@"status"] integerValue];
        
        if (errorCode == DGCRequestErrorCodeSuccess) {
            NSDictionary * infoDict = [dic objectForKey:@"data"];
            DGCUserInfo * uf = nil;
            if(infoDict){
                //创建实体
                uf = [DGCUserInfo new];
                
                //typeList
                id typeList = [infoDict objectForKey:@"typeList"];
                if ([typeList isKindOfClass:[NSArray class]]) {
                    if (((NSArray *)typeList).count > 0) {
                        uf.typeList = (NSArray *)typeList;
                    }
                }
                
                //loginAccount
                NSDictionary *loginAccountDic = [infoDict objectForKey:@"loginAccount"];
                uf.userId = [[loginAccountDic objectForKey:@"userId"] integerValue];
                uf.userName = [loginAccountDic objectForKey:@"userName"];
                uf.icon = [loginAccountDic objectForKey:@"icon"];
                uf.token = [loginAccountDic objectForKey:@"token"];
            }

            successBlock(uf,userinfo);
        }else{
            NSString *msg = [dic objectForKey:@"errMsg"];
            failerBlock(errorCode,msg,userinfo);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failerBlock(-100,@"网络错误",userinfo);
    }];
}

-(void)uploadImageById:(NSInteger)postid img:(NSData *)img
{
  
}

@end
