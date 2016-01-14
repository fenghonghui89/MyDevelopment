//
//  PPUserPay.h
//  PPAppPlatformKit
//
//  Created by seven  mr on 1/12/13.
//  Copyright (c) 2013 seven  mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPUserPay : NSObject
/**
*  拼装充值PP币 请求
*
*  @param paramPayMoney 充值金额
*
*  @return 拼装好的reques
*/
+ (NSMutableURLRequest *)webRequestPPPay:(NSString *)paramPayMoney;
/**
 *  拼装查询消费记录 请求
 *
 *  @return 返回拼装好的request
 */
+ (NSMutableURLRequest *)webRequestPPRechargeRecord;
/**
 *  拼装查询消费记录 请求
 *
 *  @return 拼装好的request
 */
+ (NSMutableURLRequest *)webRequestPPExpendRecord;

/**
 *  拼装充值并且兑换 请求
 *
 *  @param paramBillNo      订单号
 *  @param paramBillNoTitle 购买道具名称
 *  @param paramPayMoney    兑换道具所需要的金额
 *  @param paramRoleId      角色ID，若不存在一账号下多角色请写0
 *  @param paramZoneId      服务器ID，若不存在请写0
 *
 *  @return 拼装好的request
 */
+ (NSMutableURLRequest *)webRequestPayAndExchangeWithBillNo:(NSString *)paramBillNo
                                                BillNoTitle:(NSString *)paramBillNoTitle
                                                   PayMoney:(NSString *)paramPayMoney
                                                     RoleId:(NSString *)paramRoleId
                                                     ZoneId:(int)paramZoneId;


/// <summary>
/// 银联支付请求方法
/// </summary>
/// <returns>请求拼装的信息</returns>
//+ (NSString *)unionPay;
@end
