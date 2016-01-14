//
//  UnionPayViewController.m
//  PPAppPlatformKit
//
//  Created by seven  mr on 1/25/13.
//  Copyright (c) 2013 seven  mr. All rights reserved.
//

#import "PPUnionPayViewController.h"
#import "PPExchange.h"
#import "PPUserPay.h"
#import "PPAppPlatformKitConfig.h"
#import "PPAppPlatformKit.h"
#import <objc/message.h>
#import "PPCommon.h"
#import "PPAlertView.h"
#import "PPUIKit.h"

#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"
#define kNote             @"提示" 

#define kConfirm          @"确定"
#define kWaiting          @"正在获取TN,请稍后..."

@interface PPUnionPayViewController ()

@end

@implementation PPUnionPayViewController



-(void)viewDidLoad{
    
}


/**
 *SDK-v1.3以下使用下面代码实现
 */
- (void)payShowWithStatusBarOrientationInt:(UIInterfaceOrientation)paramStatusBarOrientationInt{
    
   
    [self getUPPAYCreateTime];
    

}

/**
 *  发生订单
 */

-(void)postPaa{
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_UNIONPAYCREATETIME_SDKADDRESS];
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
	NSMutableURLRequest * requestm = [[NSMutableURLRequest alloc] init];
    [requestm setTimeoutInterval:60];
	NSURL* url = [NSURL URLWithString:requestURLStr];
	[requestm setURL:url];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:requestm returningResponse:&urlResponse error:&requestError];
    [requestm release];
    if (!urlResponse) {
        if (requestError) {
            [self performSelectorOnMainThread:@selector(showerror) withObject:nil waitUntilDone:YES];
            [pool release];
            return;
        }
    }
    
    //请求银联先从服务端获取时间
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingAllowFragments error:nil];
    if (PP_ISNSLOG) {
        NSLog(@"获取系统时间%@----",[conDidFinishDic objectForKey:@"msg"]);
    }

    
    
    NSString *uppayCreateTimeStr = [[NSString alloc] initWithFormat:@"&*JDidlsLD&673TEIR32342KJSD73((2312#>(#@UIjljdsf%@",
                                    [conDidFinishDic objectForKey:@"msg"]];
    if (PP_ISNSLOG) {
        NSLog(@"uppayCreateTimeStr%@,",uppayCreateTimeStr);        
    }
    
    
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"app_id\":\"%d\",\"username\":\"%@\",\"temp_username\":\"%@\",\"sign\":\"%@\",\"user_id\":\"%lld\"}",PP_REQUEST_APPID,[[PPAppPlatformKit sharedInstance] currentShowUserName],
                                 [[PPAppPlatformKit sharedInstance] currentUserName],
                                 [PPCommon md5HexDigest:uppayCreateTimeStr],
                                 [[PPAppPlatformKit sharedInstance] currentUserId]];
    [uppayCreateTimeStr release];
    NSString *requestURLStr1 = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_UNIONPAY_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];

    if (PP_ISNSLOG) {
        NSLog(@"请求银联接口参数--\n%@",requsetBodyData);
        NSLog(@"请求requestURLStr--\n%@",requestURLStr1);
    }
    [self sendRequest:request];
    [requestUrl release];
    [pool release];
}

/**
 *  获取订单时间， 正在生成订单
 */
-(void)getUPPAYCreateTime
{
    if (alertView) {
        [alertView release];
        alertView = nil;
    }
    
    if (indicator) {
        [indicator release];
        indicator = nil;
    }
    alertView = [[UIAlertView alloc] initWithTitle:@"正在生成订单..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake(alertView.frame.size.width / 2.0f - 15, alertView.frame.size.height / 2.0f + 10 );
    [indicator startAnimating];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alertView addSubview:indicator];
    [indicator release];
    [alertView release];
    
    [self postPaa];
}

/**
 *  展示错误提示
 */
-(void)showerror{
    if ([indicator isAnimating]) {
        [indicator stopAnimating];
    }
    if (alertView) {
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        alertView = nil;
    }
    

    
    
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"获取订单失败，请检查网络！"];
    [alert setCancelButtonTitle:@"确定" block:^{

    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
}

/**
 *  发生请求
 *
 *  @param paramRequest 请求
 */

-(void)sendRequest:(NSMutableURLRequest *)paramRequest
{
    if (![NSURLConnection canHandleRequest:paramRequest])
    {
        return;
    }
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:paramRequest delegate:self];
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


#pragma mark - NSURLConnectionDataDelegate , NSURLConnectionDelegate -

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    [recvData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [recvData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
    [recvData release];
    recvData = nil;
    if (PP_ISNSLOG)
    {
        NSLog(@"开始返回响应。请求银联接口");
        NSLog(@"%@",conDidFinishDic);
    }
    
    NSString *sdkName = [conDidFinishDic objectForKey:@"sdk_name"];
    if ([sdkName isEqualToString:PP_PHP_RESPONSE_GET_SERVER_TIME_SDKNAME]) {
        
    }else {
        if ([indicator isAnimating]) {
            [indicator stopAnimating];
        }
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        NSString *tn = [[NSString alloc] initWithFormat:@"%@",[[conDidFinishDic objectForKey:@"msg"] objectForKey:@"tn"]];
        if (tn != nil && [tn integerValue] > 0)
        {
            if (PP_ISNSLOG) {
                NSLog(@"tn-%@",tn);
            }
            NSArray *windows = [[UIApplication sharedApplication] windows];
            [[windows objectAtIndex:0] makeKeyAndVisible];
            
            [UPPayPlugin startPay:tn mode:@"00"
                   viewController:[[windows objectAtIndex:0] rootViewController]
                         delegate:self];
            
        }else if ([tn integerValue] == -1){
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"银联服务器异常！"];
            [alert setCancelButtonTitle:@"确定" block:^{
                
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }else if ([tn integerValue] == -2){
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"订单生成失败！"];
            [alert setCancelButtonTitle:@"确定" block:^{
                
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
        
        [tn release];
        
    }
    
    
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self showerror];
}


#pragma mark - UPPayPluginDelegate -

//银联客户端支付回调
-(void)UPPayPluginResult:(NSString *)result
{
    if (PP_ISNSLOG)
    {
        NSLog(@"UPPayPluginResult- %@",result);
    }
    
    //此通知暂时无意义
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"PPCUPPayResultNotification" object:result];
    if (self) {
        [self release];
    }
}


#pragma mark - dealloc -

- (void)dealloc {
    if (PPDEALLOC_ISNSLOG)
    {
        NSLog(@"银联释放");
    }
    [recvData release];
    recvData = nil;
    [super dealloc];
    
    
}


#pragma mark - 过期方法 -

//- (void)payShowWithStatusBarOrientationInt:(int)paramStatusBarOrientationInt{
//    NSString* urlString = [NSString stringWithFormat:kConfigTnUrl];
//    NSURL* url = [NSURL URLWithString:urlString];
//
//    NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
//    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
//    [urlConn start];
//    [self showAlertWait];
//
//}
//
//- (void)showAlertWait
//{
//    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//    [mAlert show];
//    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
//    [aiv startAnimating];
//    [mAlert addSubview:aiv];
//    [aiv release];
//    [mAlert release];
//}
//
//- (void)hideAlert
//{
//    if (mAlert != nil)
//    {
//        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
//        mAlert = nil;
//    }
//}
//
//- (void)showAlertMessage:(NSString*)msg
//{
//    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
//    [mAlert show];
//    [mAlert release];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
//{
//    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
//    int code = [rsp statusCode];
//    if (code != 200)
//    {
//        [self hideAlert];
//        [self showAlertMessage:kErrorNet];
//        [connection cancel];
//        [connection release];
//        connection = nil;
//    }
//    else
//    {
//        if (mData != nil)
//        {
//            [mData release];
//            mData = nil;
//        }
//        mData = [[NSMutableData alloc] init];
//    }
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [mData appendData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//
//    [self hideAlert];
//    NSString* tn = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
//    NSLog(@"tn------%@",tn);
//
//    if (tn != nil && tn.length > 0)
//    {
//        [UPPayPlugin startPay:tn sysProvide:@"10955800" spId:@"0194" mode:@"01" viewController:self delegate:self];
//        [UPPayPlugin startPay:tn sysProvide:@"12345678" spId:@"1234" mode:@"01" viewController:self delegate:self];
//    }
//    [tn release];
//    [connection release];
//    connection = nil;
//
//}

//获取对象方法列表
//- (NSMutableArray *)getMethodList:(Class)clazz {
//
//    unsigned int numMethods = 0;
//    Method * methods = class_copyMethodList(clazz, &numMethods);
//    NSMutableArray * selectors = [NSMutableArray array];
//    for (int i = 0; i < numMethods; ++i) {
//        SEL selector = method_getName(methods[i]);
//        [selectors addObject:NSStringFromSelector(selector)];
//    }
//    free(methods);
//    return selectors;
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    [self hideAlert];
//    [self showAlertMessage:kErrorNet];
//    [connection release];
//    connection = nil;
//}


@end
