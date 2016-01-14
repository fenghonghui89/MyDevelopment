//
//  PPExchange.h
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  工具兑换 工具类
 */

@interface PPExchange : NSObject
<
NSURLConnectionDelegate,
NSURLConnectionDataDelegate
>
{
    NSMutableData *recvData;
}

/**
 *  直接用PP币兑换获得道具
 *
 *  @param paramBillNo 订单号
 *  @param paramAmount 该道具所需要得金额
 *  @param paramRoldId 发放道具的角色ID【若无请写0
 *  @param paramZoneId 是否添加写入成功
 */
-(void)ppExchangeToGameRequestWithBillNo:(NSString *)paramBillNo
                                  Amount:(NSString *)paramAmount
                                  RoleId:(NSString *)paramRoldId
                                  ZoneId:(int)paramZoneId;

/**
 *  同步查询当前账户信息的PP币余额
 *
 *  @return 失败返回-1，成功返回PP币余额
 */
-(double)ppSYPPMoneyRequest;
@end
