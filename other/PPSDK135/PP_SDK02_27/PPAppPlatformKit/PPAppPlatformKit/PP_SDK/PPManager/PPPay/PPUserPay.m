//
//  PPUserPay.m
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/12/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPUserPay.h"
#import "PPAppPlatformKit.h"
#import "PPAppPlatformKitConfig.h"
#import "PPCommon.h"
#import <TeironSDK/user/TRUserHelper.h>
#import "PPAlertView.h"
#import "PPCommon.h"
#import <TeironSDK/user/TRUserHelper.h>
#import "MobileGestalt.h"
@implementation PPUserPay
/**
 *  拼装充值PP币 请求
 *
 *  @param paramPayMoney 充值金额
 *
 *  @return 拼装好的reques
 */
+ (NSMutableURLRequest *)webRequestPPPay:(NSString *)paramPayMoney
{
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_PAY_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    NSString *orderCode = [NSString stringWithFormat:@"%@%llu",
                           [PPCommon PPUUID]
                           ,PP_REQUEST_USERID];
    CFStringRef value = MGCopyAnswer(kMGInverseDeviceID);

    NSString *account = nil;
    if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
        account = @"";
    }else{
        account = [[PPAppPlatformKit sharedInstance] currentShowUserName];
    }
    
    NSString *deviceKey = [PPCommon sendDeviceKey];
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"account\":\"%@\",\"temp_account\":\"%@\",\"amount\":\"%@\",\"version\":\"%@\",\"uppayOrderCode\":\"%@\",\"uuid\":\"%@\",\"deviceKey\":\"%@\",\"model\":\"%@\",\"systemVersion\":\"%@\",\"JailBreak\":\"%d\",\"reserveUnique\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,
                                 account,
                                 
                                 PP_REQUEST_USERNAME,paramPayMoney,PP_REQUEST_VERSION,orderCode,
                                 [PPCommon PPUUID],
                                 deviceKey,[PPCommon _platformString],[UIDevice currentDevice].systemVersion,
    [[PPAppPlatformKit sharedInstance] isJailBreak],value];
    if (![[PPCommon _platformString] isEqualToString:@"iPhone Simulator"]) {
        CFRelease(value);
    }
    
    if (PP_ISNSLOG) {
        NSLog(@"请求充值requsetBodyData--\n%@",requsetBodyData);
        NSLog(@"请求消费地址URL--\n%@",requestURLStr);
    }
    
//    [requestURLStr release];
//    requestURLStr = nil;
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [requestUrl release];
    requestUrl = nil;
    
//    [requsetBodyData release];
//    requsetBodyData = nil;
    
    return request;
}

/**
 *  拼装查询消费记录 请求
 *
 *  @return 返回拼装好的request
 */
+ (NSMutableURLRequest *)webRequestPPRechargeRecord
{
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return nil;
    }
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_PPRECHARGE_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"version\":\"%@\",\"username\":\"%@\",\"token\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,PP_REQUEST_VERSION,PP_REQUEST_USERNAME,tempStr];
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"version\":\"%@\",\"username\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,PP_REQUEST_USERNAME,PP_REQUEST_VERSION];
    
    
    if (PP_ISNSLOG) {
        NSLog(@"请求充值记录requsetBodyData--\n%@    ---- and pwd",requsetBodyDataLog);
        NSLog(@"请求消费记录地址URL--\n%@",requestURLStr);
    }
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [requestUrl release];
    requestUrl = nil;
    return request;
}

/**
 *  拼装查询消费记录 请求
 *
 *  @return 拼装好的request
 */
+ (NSMutableURLRequest *)webRequestPPExpendRecord
{
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return nil;
    }
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_PPEXPEND_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"version\":\"%@\",\"username\":\"%@\",\"token\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,PP_REQUEST_VERSION,
                                 PP_REQUEST_USERNAME,tempStr];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"version\":\"%@\",\"username\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,PP_REQUEST_VERSION,PP_REQUEST_USERNAME];
    
    if (PP_ISNSLOG) {
        NSLog(@"请求消费记录requsetBodyData--\n%@ --- and pwd",requsetBodyDataLog);
        NSLog(@"请求消费记录地址URL--\n%@",requestURLStr);
    }
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [requestUrl release];
    return request;
}
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
+ (NSMutableURLRequest *)webRequestPayAndExchangeWithBillNo:(NSString *)paramBillNo BillNoTitle:(NSString *)paramBillNoTitle
                                                   PayMoney:(NSString *)paramPayMoney RoleId:(NSString *)paramRoleId ZoneId:(int)paramZoneId
{
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return nil;
    }
    NSString *deviceKey = [PPCommon sendDeviceKey];

    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_PAYANDEXCHANGE_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    NSString *orderCode = [NSString stringWithFormat:@"%@%llu",
                           [PPCommon PPUUID]
                           ,PP_REQUEST_USERID];
    NSString *account = nil;
    if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
        account = @"";
    }else{
        account = [[PPAppPlatformKit sharedInstance] currentShowUserName];
    }
    
    CFStringRef value = MGCopyAnswer(kMGInverseDeviceID);
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"account\":\"%@\",\"temp_account\":\"%@\",\"uid\":\"%llu\",\"amount\":\"%@\",\"billno\":\"%@\",\"billno_title\":\"%@\",\"version\":\"%@\",\"uuid\":\"%@\",\"uppayOrderCode\":\"%@\",\"roleid\":\"%@\",\"zone\":\"%d\",\"deviceKey\":\"%@\",\"model\":\"%@\",\"systemVersion\":\"%@\",\"JailBreak\":\"%d\",\"reserveUnique\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,
                                 account,
                                 PP_REQUEST_USERNAME,
                                 PP_REQUEST_USERID,paramPayMoney,
                                 paramBillNo,paramBillNoTitle,
                                 PP_REQUEST_VERSION,
                                 [PPCommon PPUUID],
                                 orderCode,paramRoleId,paramZoneId,
                                    deviceKey,[PPCommon _platformString],[UIDevice currentDevice].systemVersion,
                                    [[PPAppPlatformKit sharedInstance] isJailBreak],value];
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"account\":\"%@\",\"temp_account\":\"%@\",\"uid\":\"%llu\",\"amount\":\"%@\",\"billno\":\"%@\",\"billno_title\":\"%@\",\"version\":\"%@\",\"uuid\":\"%@\",\"uppayOrderCode\":\"%@\",\"roleid\":\"%@\",\"zone\":\"%d\",\"deviceKey\":\"%@\",\"model\":\"%@\",\"systemVersion\":\"%@\",\"token\":\"%@\",\"JailBreak\":\"%d\",\"reserveUnique\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,
                                 account,
                                 PP_REQUEST_USERNAME,
                                 PP_REQUEST_USERID,paramPayMoney,
                                 paramBillNo,paramBillNoTitle,
                                 PP_REQUEST_VERSION,
                                 [PPCommon PPUUID],
                                 orderCode,paramRoleId,paramZoneId,
                                 deviceKey,[PPCommon _platformString],[UIDevice currentDevice].systemVersion,
                                 tempStr,[[PPAppPlatformKit sharedInstance] isJailBreak],value];
    if (PP_ISNSLOG) {
        NSLog(@"请求支付金额并直接兑换道具requsetBodyData--\n%@   --and pwd",requsetBodyDataLog);
        NSLog(@"请求支付金额并直接兑换道具地址URL--\n%@",requestURLStr);
    }
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [requestUrl release];
    if (![[PPCommon _platformString] isEqualToString:@"iPhone Simulator"]) {
        CFRelease(value);
    }
    return request;
}
#pragma mark - 过期方法 -
/// <summary>
/// 银联支付请求方法 -（旧银联SDK接口。SDK——V1.3以下使用）
/// </summary>
/// <returns>请求拼装的信息</returns>
//+ (NSMutableURLRequest *)unionPay:(NSString *)paramPayMoney{
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_UNIONPAY_SDKADDRESS];
//    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
//
//    NSString *account = nil;
//    if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
//        account = @"";
//    }else{
//        account = [[PPAppPlatformKit sharedInstance] currentShowUserName];
//    }
//    
//    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"username\":\"%@\",\"user_id\":\"%llu\",\"amount\":\"%@\",\"billno_title\":\"%@\",\"sign\":\"%@\",\"app_status\":\"%d\",\"order_title\":\"%@\",\"role\":\"%@\",\"zone\":\"%d\"}",
//                                 PP_REQUEST_APPID,
//                                 PP_REQUEST_USERNAME,
//                                 PP_REQUEST_USERID,paramPayMoney,paramBillNo,paramBillNoTitle,
//                                 PP_REQUEST_VERSION,
//                                 PP_REQUEST_UUID,
//                                 orderCode,paramRoleId,paramZoneId];
//    if (PP_ISNSLOG) {
//        NSLog(@"请求支付金额并直接兑换道具requsetBodyData--\n%@",requsetBodyData);
//        NSLog(@"请求支付金额并直接兑换道具地址URL--\n%@",requestURLStr);
//    }
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
//    [requestUrl release];
//    requestUrl = nil;
//    return request;
//}


//+ (NSString *)unionPay{
//    NSString *soapMessage = @"";
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_UNIONPAY_SDKADDRESS];
//    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
//    NSString *orderCode = [NSString stringWithFormat:@"%@%llu",PP_REQUEST_UUID,PP_REQUEST_USERID];
//    [requestUrl release];
//    NSString *requsetBodyData = [NSString stringWithFormat:
//                                 @"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"uppayOrderCode\":\"%@\"}",
//                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,orderCode];
//
//    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPMethod:@"POST"];
//
//    NSHTTPURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    JSONDecoder *jd = [[JSONDecoder alloc] init];
//    NSDictionary *responseDic = [[NSDictionary alloc] init];
//    responseDic = [jd objectWithData:responseData];
//    [jd release];
//    
//    if([[responseDic objectForKey:@"error"] intValue] != 0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请求信息有误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }else {
//        NSDictionary *responseDataDic = [responseDic objectForKey:@"data"];
//        if([[responseDataDic objectForKey:@"error"] intValue] != 0){
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"订单信息有误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//        }else {
//            NSDictionary *responseDataDic2 = [responseDataDic objectForKey:@"data"];
//            NSString *amountStr = [responseDataDic2 objectForKey:@"amount"];
//            NSString *oidStr = [responseDataDic2 objectForKey:@"order_id"];
//            NSString *otitleStr = [responseDataDic2 objectForKey:@"order_title"];
//            NSString *senderSignature = [responseDataDic2 objectForKey:@"senderSignature"];
//            NSString *submitTime = [responseDataDic2 objectForKey:@"submitTime"];
//            NSString *purchaseAdvice = [responseDataDic2 objectForKey:@"PurchaseAdvice.MARsp"];
//            if ([purchaseAdvice isEqualToString:@""]) {
//                //测试--暂时不用
////                if( 1==2){
////                    soapMessage = [NSString stringWithFormat:
////                                   @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
////                                   "<cupMobile version=\"1.01\" application=\"All\">"
////                                   "<transaction type=\"Purchase.MARsp\">"
////                                   "<submitTime>%@</submitTime>"
////                                   "<order id=\"%@\">%@</order>"
////                                   "<transAmount currency = \"156\">%@</transAmount>"
////                                   "<terminal id=\"00000001\"/>"
////                                   "<merchant name=\"广州铁人网络科技有限公司\" id=\"100011000110116\"/>"
////                                   "</transaction>"
////                                   "<senderSignature>%@"
////                                   "</senderSignature>"
////                                   "</cupMobile>",submitTime,oidStr,otitleStr,amountStr,senderSignature];
////                }else {
//                    soapMessage = [NSString stringWithFormat:
//                                   @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
//                                   "<cupMobile version=\"1.01\" application=\"All\">"
//                                   "<transaction type=\"Purchase.MARsp\">"
//                                   "<submitTime>%@</submitTime>"
//                                   "<order id=\"%@\">%@</order>"
//                                   "<transAmount currency = \"156\">%@</transAmount>"
//                                   "<terminal id=\"%@\"/>"
//                                   "<merchant name=\"广州铁人网络科技有限公司\" id=\"%@\"/>"
//                                   "</transaction>"
//                                   "<senderSignature>%@"
//                                   "</senderSignature>"
//                                   "</cupMobile>",submitTime,oidStr,otitleStr,amountStr,
//                                   @"00000001",
//                                   @"898110248990070",
//                                   senderSignature];
////                }
//
//            }else{
//                soapMessage = [NSString stringWithFormat:
//                               @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
//                               "<cupMobile version=\"1.01\" application=\"All\">"
//                               "<transaction type=\"PurchaseAdvice.MARsp\">"
//                               "<submitTime>%@</submitTime>"
//                               "<order id=\"%@\">%@</order>"
//                               "<transAmount currency = \"156\">%@</transAmount>"
//                               "<terminal id=\"%@\"/>"
//                               "<merchant name=\"广州铁人网络科技有限公司\" id=\"%@\"/>"
//                               "</transaction>"
//                               "<senderSignature>%@"
//                               "</senderSignature>"
//                               "</cupMobile>",submitTime,oidStr,otitleStr,amountStr,
//                               @"00000001",
//                               @"898110248990070",
//                               senderSignature];
//            }
//        }
//    }
//    return soapMessage;
//}


@end
