//
//  PPAlixPay.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-7-16.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPAlixPay.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "PPCommon.h"
#import "PPAppPlatformKit.h"
#import "DataVerifier.h"
#import "PartnerConfig.h"
#import "PPAlertView.h"
#import "AlixLibService.h"



@implementation PPAlixPay


- (id)init{
    
    self = [super init];
    if (self) {
        if (PPDEALLOC_ISNSLOG) {
            NSLog(@"支付宝init");
        }
    }
    return self;
}

-(void)paymentResultDelegate:(NSString *)result
{
    if (PP_ISNSLOG) {
        NSLog(@"支付宝支付回掉-%@",result);
        
    }
    
}


- (NSString *)resultFromURL:(NSURL *)url {
//    releaseTag = NO;
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return query;
}

- (void)handleOpenURL:(NSURL *)url {
	NSString * result = nil;
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    [self paymentResult:result];
}



#pragma mark - 支付结果提示 -

-(void)paymentResult:(NSString *)resultd
{
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    if (PP_ISNSLOG) {
        NSLog(@"%d-",result.statusCode);
    }
	if (result)
    {
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString *key = AlipayPubKey;
            //            //签约帐户后获取到的支付宝公钥
            //			id<DataVerifier> verifier = CreateRSADataVerifier(key);
            NSString *message = @"";
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            message = @"支付成功";
            //			}
            //            else
            //            {
            //                message = @"签名错误";
            //            }
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:message];
            [alert setCancelButtonTitle:@"确定" block:^{
                
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
        else
        {
            //交易失败
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:result.statusMessage];
            [alert setCancelButtonTitle:@"确定" block:^{
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
    }
    else
    {
        //失败
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:result.statusMessage];
        [alert setCancelButtonTitle:@"确定" block:^{
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    
}

#pragma mark - 生成订单信息及签名 -

-(void)alixPay:(AlixPayOrder *)paramAlixPayOrder{
	/*
	 *生成订单信息及签名
	 *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
	 */
	//将商品信息赋予AlixPayOrder的成员变量
	
    //将商品信息拼接成字符串
	NSString *orderSpec = [paramAlixPayOrder description];
    if (PP_ISNSLOG) {
        NSLog(@"orderSpec = %@",orderSpec);
    }
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey_AiHe);
    
	NSString *signedString = [signer signString:orderSpec];
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        //获取安全支付单例并调用安全支付接口
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
        //        NSString *appScheme = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        //正式库为下，如果调试模式注释下句
        NSString *appScheme = [NSString stringWithFormat:@"teiron%d",PP_REQUEST_APPID];
        if (PP_ISNSLOG) {
            //            NSLog(@"*****appScheme-%@",appScheme);
            NSLog(@"orderString--%@",orderString);
        }
        [AlixLibService payOrder:orderString
                       AndScheme:appScheme
                         seletor:@selector(paymentResult:)
                          target:[PPAppPlatformKit sharedInstance]];
        
	}
}


#pragma mark - 获取系统时间 ，请求生成订单 -
//获取订单号
- (void)getBillNoAlixPay{
    //     ALIXPAY
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_ALIXPAYCREATETIME_SDKADDRESS];
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
    
    
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingAllowFragments error:nil];
    if (PP_ISNSLOG) {
        NSLog(@"获取系统时间%@--",[conDidFinishDic objectForKey:@"msg"]);
    }
    
    
    
    NSString *uppayCreateTimeStr = [[NSString alloc] initWithFormat:@"&*JDidlsLD&673TEIR32342KJSD73((2312#>(#@UIjljdsf%@",[conDidFinishDic objectForKey:@"msg"]];
    if (PP_ISNSLOG) {
        NSLog(@"uppayCreateTimeStr%@,",uppayCreateTimeStr);
    }
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"app_id\":\"%d\",\"username\":\"%@\",\"temp_username\":\"%@\",\"sign\":\"%@\",\"user_id\":\"%lld\",\"version\":\"%@\"}",PP_REQUEST_APPID,[[PPAppPlatformKit sharedInstance] currentShowUserName],
                                 [[PPAppPlatformKit sharedInstance] currentUserName],
                                 [PPCommon md5HexDigest:uppayCreateTimeStr],
                                 [[PPAppPlatformKit sharedInstance] currentUserId],
                                 PP_REQUEST_VERSION];
    [uppayCreateTimeStr release];
    
    
    
    NSString *requestURLStr1 = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_ALIXPAY_SDKADDRESS];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    if (PP_ISNSLOG) {
        NSLog(@"请求支付宝接口参数--\n%@",requsetBodyData);
        NSLog(@"请求requestURLStr--\n%@",requestURLStr1);
    }
    [self sendRequest:request];
    [requestUrl release];
    [pool release];
}

#pragma mark - 生成订单 ,打印错误 -

- (void)showViewDidLoad{
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
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [indicator startAnimating];
    [alertView addSubview:indicator];
    [indicator release];
    [alertView release];
    [self getBillNoAlixPay];
}



-(void)showerror{
    
    if ([indicator isAnimating]) {
        [indicator stopAnimating];
    }
    if (alertView) {
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        alertView = nil;
    }
    
    NSString *title = [[PPAppPlatformKit sharedInstance] currentAddress];
	NSString *message = @"获取订单失败，请检查网络！";
    
	PPAlertView *alert = [[PPAlertView alloc] initWithTitle:title message:message];
    [alert setCancelButtonTitle:@"确定" block:^{
        
    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
    
}

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


#pragma - NSURLConnectionDataDelegate , NSURLConnectionDelegate -

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
    
    if (PP_ISNSLOG) {
        NSLog(@"开始返回响应。请求支付宝接口");
        NSLog(@"%@",conDidFinishDic);
    }
    
    NSString *sdkName = [conDidFinishDic objectForKey:@"sdk_name"];
    if ([sdkName isEqualToString:PP_PHP_RESPONSE_GET_SERVER_TIME_SDKNAME]) {
        
    }else {
        if ([[conDidFinishDic objectForKey:@"error"] intValue] != 0) {
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"请求订单信息错误"];
            [alert setCancelButtonTitle:@"确定" block:^{
                
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
            return;
        }
        if ([indicator isAnimating]) {
            [indicator stopAnimating];
        }
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        NSDictionary *orderDic = [conDidFinishDic objectForKey:@"msg"];
        if (PP_ISNSLOG) {
            NSLog(@"获取支付宝请求参数-%@",orderDic);
        }
        /**
         *  NOTE 商家（即是我们自己铁人，资金转入账号接口）
         */
        AlixPayOrder *order = [[AlixPayOrder alloc] init];
        order.partner = PartnerID_AiHe;
        order.seller = SellerID_AiHe;
        //订单ID（由商家自行制定）
        order.tradeNO = [orderDic objectForKey:@"orderId"];
        //        order.tradeNO = @"W7MUBK8DM87D47V";
        //商品标题
        order.productName = [orderDic objectForKey:@"orderTitle"];
        //商品描述
        order.productDescription = [orderDic objectForKey:@"orderDes"];
        //商品价格
        order.amount = [orderDic objectForKey:@"amount"];
        //回调URL
        order.notifyURL = [orderDic objectForKey:@"notifyUrl"];
        [self alixPay:order];
        [order release];
    }
    [recvData release];
    recvData = nil;
    
}


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
    [recvData release];
    recvData = nil;
    [self showerror];
}

#pragma - dealloc -

- (void)dealloc {
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"支付宝释放");
    }
    [super dealloc];
    
}


@end
