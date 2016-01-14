////
////  PPAccountsSecurityCenter.m
////  PPAppPlatformKit
////
////  Created by 张熙文 on 1/11/13.
////  Copyright (c) 2013 张熙文. All rights reserved.
////
//
//#import "PPAccountsSecurityCenter.h"
//#import "PPAppPlatformKitConfig.h"
//#import "PPCommon.h"
//
//
//
//@implementation PPAccountsSecurityCenter
//
//
//
//
//
//
//
//
///// <summary>
///// 根据请求地址完成瓶装
///// </summary>
///// <param name="RequsetAddress">请求地址</param>
///// <returns>返回拼装好的request信息</returns>
//+ (NSMutableURLRequest *)webRequest:(NSString *)paramRequsetAddress{
//    
//    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
//    if ([tempStr isEqualToString:@""]) {
//        return nil;
//    }
//    NSString *addressStr = [NSString stringWithFormat:@"http://bbs.996.com/sdkLogin.php?username=%@&pwd=%@",
//                            [[PPAppPlatformKit sharedInstance] currentUserName],tempStr];
//    NSURL *requestUrl = [[NSURL alloc] initWithString:[addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
//    [requestUrl release];
//    requestUrl = nil;
//    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"account\":\"%@\",\"version\":\"%@\"}",
//                                 [[PPAppPlatformKit sharedInstance] currentShowUserName],PP_REQUEST_USERNAME,PP_REQUEST_VERSION];
//    
//    
////
//    
//    if (PP_ISNSLOG) {
//        NSLog(@"请求requsetBodyData--\n%@",requsetBodyData);
//        NSLog(@"请求地址URL--\n%@",paramRequsetAddress);
//    }
//    [request setHTTPMethod:@"POST"];
////    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setTimeoutInterval:10];
//    
//    return request;
//}
//
///// <summary>
///// 拼装帮助
///// </summary>
///// <returns>返回拼装好的request信息</returns>
//+ (NSMutableURLRequest *)webRequestHelp
//{
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_HELP_SDKADDRESS];
//    return [PPAccountsSecurityCenter webRequest:requestURLStr];
//}
//
//
///// <summary>
///// 密保拼装
///// </summary>
///// <returns>返回拼装好的request信息</returns>
//+(NSMutableURLRequest *)webRequestSecurity{
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_SECURITY_SDKADDRESS];
//    return [PPAccountsSecurityCenter webRequest:requestURLStr];
//}
//
///// <summary>
///// 论坛请求
///// </summary>
///// <returns>返回拼装好的request信息</returns>
//+ (NSMutableURLRequest *)webRequestBBS
//{
//    return [PPAccountsSecurityCenter webRequest:PP_PHP_REQUEST_BBS_SDKADDRESS];
//}
//
//
//
///// <summary>
///// 拼装忘记密码
///// </summary>
///// <returns>返回拼装好的request信息</returns>
//+ (NSMutableURLRequest *)webRequestForgetPassWord
//{
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_FORGETPASSWORD_SDKADDRESS];
//    return [PPAccountsSecurityCenter webRequest:requestURLStr];
//}
//
///// <summary>
///// 根据用户名获取用户安全级别
///// </summary>
///// <param name="UserName">当前登陆用户名</param>
///// <returns>无返回</returns>
//-(void)ppQuestionAnswerSettedRequest:(NSString *)paramUserName
//{
//    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"username\":\"%@\",\"version\":\"%@\"}",PP_REQUEST_APPID,PP_REQUEST_APPKEY,paramUserName,PP_REQUEST_VERSION];
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_ACCOUNTSECURITYLEVEL_SDKADDRESS];
//    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setTimeoutInterval:10];
//    if (PP_ISNSLOG) {
//        NSLog(@"获取帐号安全级别requsetBodyData--\n%@",requsetBodyData);
//        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
//    }
//    
//    [self sendRequest:request];
//    [requestUrl release];
//    requestUrl = nil;
//}
//
//
//-(void)sendRequest:(NSMutableURLRequest *)paramRequest
//{
//    if (![NSURLConnection canHandleRequest:paramRequest])
//    {
//        return;
//    }
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:paramRequest delegate:self];
//    if (recvData) {
//        [recvData release];
//        recvData = nil;
//    }
//    if(connection){
//        recvData = [[NSMutableData alloc] init];
//    }
//    [connection start];
//    [connection release];
//    connection = nil;
//}
//
//
//#pragma mark NSURLConnection delegate Methods
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    [recvData setLength:0];
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [recvData appendData:data];
//}
//
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION object:nil];
//}
//
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    
//    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
//    [recvData release];
//    recvData = nil;
//
//    if (PP_ISNSLOG) {
//        NSLog(@"请求返回的DIC-%@",conDidFinishDic);
//    }
//    if (conDidFinishDic == nil){
//        if (![conDidFinishDic isKindOfClass:[NSDictionary class]]){
//            return;
//        }
//        return;
//    }
//
//    NSString *grade;
//    if([[conDidFinishDic objectForKey:@"error"] intValue] == 0){
//        grade = [[conDidFinishDic objectForKey:@"data"] objectForKey:@"save_grade"];
//    }else{
//        grade = @"";
//    }
////    if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
////        if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
////            [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_ACCOUNTSECURITYLEVEL_NOTIFICATION object:@"临时会员"];
////        }else{
////            if([[conDidFinishDic objectForKey:@"error"] intValue] == 0){
////                [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_ACCOUNTSECURITYLEVEL_NOTIFICATION object:grade];
////            }
////        }
////
////    }else{
////        if([[conDidFinishDic objectForKey:@"error"] intValue] == 0){
////            [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_ACCOUNTSECURITYLEVEL_NOTIFICATION object:grade];
////        }
////    }
//}
//@end
