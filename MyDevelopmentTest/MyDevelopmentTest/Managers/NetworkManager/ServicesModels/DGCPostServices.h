//
//  DGCPostManager.h
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DGCServerCallBackDelegate.h"
@interface DGCPostServices : NSObject
/**
 *  单例模式
 *
 *  @return 单例实例
 */
+ (instancetype)share;

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
              delegate:(id<DGCServerCallBackDelegate>)degelate;

@end
