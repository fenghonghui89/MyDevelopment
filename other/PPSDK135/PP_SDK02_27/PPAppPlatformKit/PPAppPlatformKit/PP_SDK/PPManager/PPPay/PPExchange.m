//
//  PPExchange.m
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPExchange.h"
#import "PPAppPlatformKitConfig.h"
#import "PPAppPlatformKit.h"
#import "PPCommon.h"
#import "PPAlertView.h"
#import "PPMBProgressHUD.h"
#import "MobileGestalt.h"


static PPMBProgressHUD *hud;

@implementation PPExchange

/**
 *  直接用PP币兑换获得道具
 *
 *  @param paramBillNo 订单号
 *  @param paramAmount 该道具所需要得金额
 *  @param paramRoldId 发放道具的角色ID【若无请写0
 *  @param paramZoneId 是否添加写入成功
 */
-(void)ppExchangeToGameRequestWithBillNo:(NSString *)paramBillNo Amount:(NSString *)paramAmount
                                  RoleId:(NSString *)paramRoldId ZoneId:(int)paramZoneId
{
    hud = [PPMBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [hud setLabelText:@"正在购买..."];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *deviceKey = [PPCommon sendDeviceKey];
    CFStringRef value = MGCopyAnswer(kMGInverseDeviceID);
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"account\":\"%@\",\"billno\":\"%@\",\"amount\":\"%@\",\"uuid\":\"%@\",\"zone\":\"%d\",\"roleid\":\"%@\",\"version\":\"%@\",\"deviceKey\":\"%@\",\"model\":\"%@\",\"systemVersion\":\"%@\",\"token\":\"%@\",\"JailBreak\":\"%d\",\"reserveUnique\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,PP_REQUEST_USERNAME,paramBillNo,paramAmount,
                                 [PPCommon PPUUID],
                                 paramZoneId,paramRoldId,PP_REQUEST_VERSION,
                                 deviceKey,[PPCommon _platformString],[UIDevice currentDevice].systemVersion
                                 ,tempStr,[[PPAppPlatformKit sharedInstance] isJailBreak],value];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"account\":\"%@\",\"billno\":\"%@\",\"amount\":\"%@\",\"uuid\":\"%@\",\"zone\":\"%d\",\"roleid\":\"%@\",\"version\":\"%@\",\"deviceKey\":\"%@\",\"model\":\"%@\",\"systemVersion\":\"%@\",\"JailBreak\":\"%d\",\"reserveUnique\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,PP_REQUEST_USERNAME,paramBillNo,paramAmount,
                                 [PPCommon PPUUID],
                                 paramZoneId,paramRoldId,PP_REQUEST_VERSION,
                                    deviceKey,[PPCommon _platformString],[UIDevice currentDevice].systemVersion,
                                    [[PPAppPlatformKit sharedInstance] isJailBreak],value
                                 ];
    if (![[PPCommon _platformString] isEqualToString:@"iPhone Simulator"]) {
        CFRelease(value);
    }
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_EXCHANGE_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    if (PP_ISNSLOG) {
        NSLog(@"请求兑换requsetBodyData--\n%@  --- and pwd",requsetBodyDataLog);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    
    [self sendRequest:request];
    [requestUrl release];
}

/**
 *  同步查询当前账户信息的PP币余额
 *
 *  @return 失败返回-1，成功返回PP币余额
 */
-(double)ppSYPPMoneyRequest
{
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"uuid\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,
//                                 [PPCommon PPUUID],
                                 [[UIDevice currentDevice] valueForKeyPath:@"uniqueIdentifier"],
                                 PP_REQUEST_VERSION];
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_BALANCE_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    if (PP_ISNSLOG) {
        NSLog(@"查询当前账户信息 PPSY-requsetBodyData--%@",requsetBodyData);
    }
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];


    
    if (responseData == nil) {
        [hud hide:YES];
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:[[PPAppPlatformKit sharedInstance] currentAddress]
                                                        message:@"购买失败,请检查你的网络"];
        [alert setCancelButtonTitle:@"确定" block:^{
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        [requestUrl release];

        return -2.0;
    }
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSString *str  = [[NSString alloc] initWithData:responseData encoding:NSStringEncodingConversionAllowLossy];
    if (PP_ISNSLOG) {
        NSLog(@"请求查询余额requsetBodyData--\n%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"同步返回Dic--\n%@",conDidFinishDic);
        NSLog(@"同步返回str--\n%@",str);
        
    }
    
    
    [str release];
    
    [requestUrl release];
    [hud hide:YES];
    if (conDidFinishDic != nil) {
        if([[conDidFinishDic objectForKey:@"error"] intValue] == 0){
            return  [[[conDidFinishDic objectForKey:@"data"] objectForKey:@"ppmoney"] doubleValue];
        }else {
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:[[PPAppPlatformKit sharedInstance] currentAddress]
                                                            message:@"系统异常，请稍后再试"];
            [alert setCancelButtonTitle:@"确定" block:^{
                alert.dismissalStyle = PPAlertViewDismissalStyleTumble3D;
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
    }else{
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:[[PPAppPlatformKit sharedInstance] currentAddress]
                                                        message:@"请检查你的网络"];
        [alert setCancelButtonTitle:@"确定" block:^{
            alert.dismissalStyle = PPAlertViewDismissalStyleTumble3D;
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return -2.0;
    }
    return 0;
}

#pragma mark - 发生请求 -

-(void)sendRequest:(NSMutableURLRequest *)request
{
    if (![NSURLConnection canHandleRequest:request])
    {
        return;
    }
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (recvData) {
        [recvData release];
        recvData = nil;
    }
    
    if(connection){
        recvData = [[NSMutableData alloc] init];
    }
    [connection start];
    [connection release];
}

#pragma mark  - NSURLConnectionDelegate ，NSURLConnectionDataDelegate -

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [recvData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [recvData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (PP_ISNSLOG) {
        NSLog(@"connection didFailWithError");
    }
    [hud setLabelText:@"通信错误，稍后再试"];
    [hud hide:YES afterDelay:2];
    [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION object:nil];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
    if (PP_ISNSLOG) {
        NSLog(@"【PPExchange】请求返回的dic -%@",conDidFinishDic);
    }
    
    int result = [[conDidFinishDic objectForKey:@"error"] intValue];
    NSString *getSDKName = [conDidFinishDic objectForKey:@"sdk_name"];
    if ([getSDKName isEqualToString:PP_PHP_RESPONSE_BALANCE_SDKNAME]) {
        if (result != 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_BALANCE_NOTIFICATION object:@"-1"];
        }else{
            NSDictionary *dicPPmoney = [conDidFinishDic objectForKey:@"data"];
            NSString *ppMoney = [dicPPmoney objectForKey:@"ppmoney"];
            [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_BALANCE_NOTIFICATION object:ppMoney];
        }
    }else if([getSDKName isEqualToString:PP_PHP_RESPONSE_EXCHANGE_SDKNAME]){
        [hud hide:YES];
        NSString *msg;
        if(result == 0){
            msg = @"购买成功";
        }else if(result == 1){
            msg = @"禁止访问";
        }else if(result == 2){
            msg = @"该用户不存在";
        }else if(result == 3){
            msg = @"必选参数缺失";
        }else if(result == 4){
            msg = @"PP币不足";
        }else if(result == 5){
            msg = @"该游戏数据不存在";
        }else if(result == 6){
            msg = @"开发者数据不存在";
        }else if(result == 7){
            msg = @"该区数据不存在";
        }else if(result == 8){
            msg = @"系统繁忙";
        }else if(result == 9){
            msg = @"购买失败";
        }else if(result == 10){
            msg = @"与开发商服务器通信失败，如果长时间未收到商品请联系PP客服：电话：020-38276673　 QQ：800055602";
        }else if(result == 11){
            msg = @"开发商服务器未成功处理该订单，如果长时间未收到商品请联系PP客服：电话：020-38276673　 QQ：800055602";
        }else if(result == 88){
            msg = @"非法访问，可能用户已经下线";
        }else {
            msg = @"其他错误";
        }

        
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:msg];
        [alert setCancelButtonTitle:@"确定" block:^{

        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        [[[PPAppPlatformKit sharedInstance] delegate] ppPayResultCallBack:result];
    }
    [recvData release];
    recvData = nil;

}



@end
