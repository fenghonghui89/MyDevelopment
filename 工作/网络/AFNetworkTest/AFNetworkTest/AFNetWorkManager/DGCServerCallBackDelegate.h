//
//  DGCServerCallBackDelegate.h
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGCBaseModel.h"
#import "DGCDefine.h"
@protocol DGCServerCallBackDelegate <NSObject>

@optional
//成功回调
- (void)DGCServicesSuccess:(DGCBaseModel *)data
                errorCode:(DGCRequestErrorCode)code
                      msg:(NSString *)msg
                 userInfo:(NSDictionary *)userInfo;
//失败回调
- (void)DGCServicesFailer:(DGCBaseModel *)data
               errorCode:(DGCRequestErrorCode)code
                     msg:(NSString *)msg
                userInfo:(NSDictionary *)userInfo;

@end
