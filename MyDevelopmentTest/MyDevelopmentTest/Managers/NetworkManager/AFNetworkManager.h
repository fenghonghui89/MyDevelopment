//
//  AFNetworkManager.h
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "MDDefine.h"
#import "DGCBaseModel.h"

typedef void (^DGCServiceSuccessBlock)(DGCBaseModel *baseModel,NSDictionary *userInfo);
typedef void (^DGCServiceFailedBlock)(DGCRequestErrorCode code,NSString *msg, NSDictionary *userInfo);


@interface AFNetworkManager : NSObject

+(AFNetworkManager *)share;


#pragma mark - < interfaces > -
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

/**
 *  最近更新帖子列表
 *
 *  @param since        从哪张帖子之后的帖子
 *  @param before       从哪张帖子之前的帖子
 *  @param per_page     返回几条记录，默认为`5`
 *  @param site         可选，帖子所在站点ID，默认为当前站点
 *  @param host         可选，帖子所属主体ID
 *  @param type         可选，帖子所属类型ID
 *  @param user         可选，发帖人用户ID
 *  @param userinfo     自定义信息
 *  @param successBlock 成功回调
 *  @param failerBlock  失败回调
 */
-(void)getPostsBySince:(NSInteger)since
                before:(NSInteger)before
              per_page:(NSInteger)per_page
                  site:(NSInteger)site
              location:(NSInteger)location
                 place:(NSInteger)place
                  type:(NSInteger)type
                  user:(NSInteger)user
              userinfo:(NSDictionary *)userinfo
       successCallBack:(DGCServiceSuccessBlock)successBlock
        failerCallBack:(DGCServiceFailedBlock)failerBlock;
@end
