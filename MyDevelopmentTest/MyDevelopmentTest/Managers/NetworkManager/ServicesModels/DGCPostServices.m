//
//  DGCPostManager.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCPostServices.h"
#import "AFNetworkManager.h"
@interface DGCPostServices()
@property(nonatomic,strong)AFNetworkManager *afNetworkManager;
@end
@implementation DGCPostServices
/**
 *  单例模式
 *
 *  @return 单例实例
 */
+ (instancetype)share
{
  static DGCPostServices *share = nil;
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
 *  @param delegate     代理
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
              delegate:(id<DGCServerCallBackDelegate>)degelate
{
  [_afNetworkManager getPostsBySince:since
                              before:before
                            per_page:per_page
                                site:site
                            location:location
                               place:place
                                type:type
                                user:user
                            userinfo:userinfo
                     successCallBack:^(DGCBaseModel *baseModel, NSDictionary *userInfo) {
                       [degelate DGCServicesSuccess:baseModel errorCode:DGCRequestErrorCodeSuccess msg:@"ok" userInfo:userinfo];
                     } failerCallBack:^(DGCRequestErrorCode code, NSString *msg, NSDictionary *userInfo) {
                       [degelate DGCServicesFailer:nil errorCode:code msg:msg userInfo:userinfo];
                     }];
}

@end
