//
//  ViewController.m
//  AliPayTest
//
//  Created by 冯鸿辉 on 16/1/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#define appScheme @"hanyalipaytest"

#import "ViewController.h"

#import "RSADataSigner.h"
#import "Order.h"
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>
@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.webview.delegate = self;
  NSString *urlString = @"http://dev.tpages.net.cn/alipayapp/index.php";
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  [self.webview loadRequest:req];
}


#pragma mark - < method >

#pragma mark * other

/**
 随机订单号

 @return 随机订单号
 */
- (NSString *)generateTradeNO
{
  static int kNumber = 15;
  
  NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  NSMutableString *resultStr = [[NSMutableString alloc] init];
  srand((unsigned)time(0));
  for (int i = 0; i < kNumber; i++)
  {
    unsigned index = rand() % [sourceStr length];
    NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
    [resultStr appendString:oneStr];
  }
  return resultStr;
}

#pragma mark * pay
-(void)alipay_new{
  //重要说明
  //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
  //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
  //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
  /*============================================================================*/
  /*=======================需要填写商户app申请的===================================*/
  /*============================================================================*/
  NSString *appID = @"";
  
  // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
  // 如果商户两个都设置了，优先使用 rsa2PrivateKey
  // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
  // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
  // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
  NSString *rsa2PrivateKey = @"";
  NSString *rsaPrivateKey = @"";
  /*============================================================================*/
  /*============================================================================*/
  /*============================================================================*/
  
  //partner和seller获取失败,提示
  if ([appID length] == 0 ||
      ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"缺少appId或者私钥。"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    return;
  }
  
  /*
   *生成订单信息及签名
   */
  //将商品信息赋予AlixPayOrder的成员变量
  Order* order = [Order new];
  
  // NOTE: app_id设置
  order.app_id = appID;
  
  // NOTE: 支付接口名称
  order.method = @"alipay.trade.app.pay";
  
  // NOTE: 参数编码格式
  order.charset = @"utf-8";
  
  // NOTE: 当前时间点
  NSDateFormatter* formatter = [NSDateFormatter new];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  order.timestamp = [formatter stringFromDate:[NSDate date]];
  
  // NOTE: 支付版本
  order.version = @"1.0";
  
  // NOTE: sign_type 根据商户设置的私钥来决定
  order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
  
  // NOTE: 商品数据
  order.biz_content = [BizContent new];
  order.biz_content.body = @"我是测试数据";
  order.biz_content.subject = @"1";
  order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
  order.biz_content.timeout_express = @"30m"; //超时时间设置
  order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
  
  //将商品信息拼接成字符串
  NSString *orderInfo = [order orderInfoEncoded:NO];
  NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
  NSLog(@"orderSpec = %@",orderInfo);
  
  // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
  //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
  NSString *signedString = nil;
  RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
  if ((rsa2PrivateKey.length > 1)) {
    signedString = [signer signString:orderInfo withRSA2:YES];
  } else {
    signedString = [signer signString:orderInfo withRSA2:NO];
  }
  
  // NOTE: 如果加签成功，则继续执行支付
  if (signedString != nil) {
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                             orderInfoEncoded, signedString];
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
      NSLog(@"reslut = %@",resultDic);
    }];
  }

}


/**
 旧版本 直接传sign
 */
-(void)alipay_old_sign{
  
//  Order *order = [[Order alloc] init];
//  order.partner = @"2088021073337277";
//  order.seller_id = @"tp_pay@tpages.com";
//  order.out_trade_no = @"1452574539";
//  order.subject = @"subject";
//  order.body = @"body";
//  order.total_fee = @"0.01";
//  order.notify_url = @"http://dev.tpages.net.cn/alipayapp/notify.php";
//  order.service = @"mobile.securitypay.pay";
//  order.payment_type = @"1";
//  order._input_charset = @"utf-8";
//  order.sign = @"T4lZTsHhWIRfFXaZvMEgEtNC6qTeo6jqHe0U4D6qwXcSX38eBDTUysVbfLdpIatoCDp6atz59cG7s0Cf17tRIrkK29rPhdXXiKxGFcM1ATVlGMal2h4rqsgLtxU8S0bKYzZ6oyjIoUR2RxApBesDHp8WPsBmk5%2FtbU870n%2FZS3I%3D";
//  order.sign_type = @"RSA";
//  
//  //将商品信息拼接成字符串
//  NSString *orderSpec = [order description];
//  NSLog(@"orderSpec = %@",orderSpec);
//  
//  [[AlipaySDK defaultService] payOrder:orderSpec fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//    NSLog(@"支付宝reslut = %@",resultDic);
//  }];
}


/**
 旧版本 客户端签名
 */
-(void)alipay_old_rsa{
  
//  NSString *partner = @"2088021073337277";
//  NSString *seller = @"tp_pay@tpages.com";
//  NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALjgQC6rWplJUj4g0G4zWjseZiDuRJZUBq+ity+kZKM0tvPyuPpSvw444zc9Tqw9mBGup7S8Y2fCyfV5B68tG7Sl4WkHhTP9EnNQuKndHkMBOOWhr/DixHQ/nBNcx1KBrMwXcegCqMWs9uJEuKYq37kVdh9QSYDxN5TLhs40lUn/AgMBAAECgYEAp/s61izkWTuB+umd+UO3zNfGPE3DDES0/ol+oU9iEdkoE2iMIwdkieuuqNaP0Xj137surs4uFG2tS9n43XbDIEngwTmR8sC+Y1IGL981WGLTj9oRPcN+wj52A/MAQqZQZG+8sPa4aQzUnGV7C7mv6O/0c9UDkAEyl6A87NhHHuECQQDdawd42dWNvL0xsQDw187qqIA0F7ljQk3vOQaxhx19Qwo4PtqkoOZ3wySIIS257IpnAYd6fs2qblocUaeqlQMlAkEA1cAoHKl+PH92qljekbKRWviGYuBspf3ECEydgh3Xi3WGX1c642GngQNYgsNiaOLwFnyOTVero1v6aPVvFa+hUwJBAMsAc+tTHL5EitliRVCLLARs1I3uKmRcyANKL17YWCseKeKDjgZeFq861OWSNdA+lG34MvQWCg31+tv36Vc2I5kCQGovfH3IoaKSO7QiU+cTS2xi2/fQv4iyiSkKTpDuHD72kltYrTN6Nsk7jUPgpkmuu1Cgbdz0OZr8vWhYzOd8CWsCQQCbXQGJdC0kKC4A30qzRMmxK445lBrtFuULvrrt9pBdGqNumt8Ng/gNuH7Xef0ffzzeq4q1LEsHJC5i+0JDh+Aw";//pkcs8格式私钥，把头尾和换行去掉
//  
//  Order *order = [[Order alloc] init];
//  order.partner = partner;
//  order.seller_id = seller;
//  order.out_trade_no = @"1452574539";
//  order.subject = @"subject";
//  order.body = @"\u8ba2\u5355\u53f7:1601077488";
//  order.total_fee = @"0.01";
//  order.notify_url = @"http://mall.local.dev.tpages.com/alipaywapcb";
//  order.service = @"mobile.securitypay.pay";
//  order.payment_type = @"1";
//  order._input_charset = @"utf-8";
//  
//  //将商品信息拼接成字符串
//  NSString *orderSpec = [order description];
//  NSLog(@"orderSpec = %@",orderSpec);
//  
//  //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//  id<DataSigner> signer = CreateRSADataSigner(privateKey);
//  NSString *signedString = [signer signString:orderSpec];
//  
//  //将签名成功字符串格式化为订单字符串,请严格按照该格式
//  NSString *orderString = nil;
//  if (signedString != nil) {
//    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                   orderSpec, signedString, @"RSA"];
//    NSLog(@"orderStr: %@",orderString);
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//      NSLog(@"pay reslut = %@",resultDic);
//    }];
//  }
}


/**
 旧版本 公司测试
 */
-(void)alipay_old_tpagesTest{
  
//  //初始化
//  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
//  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:conf];
//  
//  //设置manager
//  AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//  responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//  manager.responseSerializer = responseSerializer;
//  
//  AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
//  requestSerializer.timeoutInterval = 20;
//  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//  manager.requestSerializer = requestSerializer;
//  
//  manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//  manager.securityPolicy.allowInvalidCertificates = YES;
//  
//  //开始任务
//  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.tpages.net.cn/alipayapp/index.php?action=pay"]];
//  
//  NSURLSessionTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//    if (error) {
//      NSLog(@"支付error:%@",error.localizedDescription);
//    }else{
//      NSDictionary *dic = (NSDictionary *)responseObject;
//      Order *order = [[Order alloc] init];
//      order.partner = [dic objectForKey:@"partner"];
//      order.seller_id = [dic objectForKey:@"seller_id"];
//      order.out_trade_no = [dic objectForKey:@"out_trade_no"];
//      order.subject = [dic objectForKey:@"subject"];
//      order.body = [dic objectForKey:@"body"];
//      order.total_fee = [dic objectForKey:@"total_fee"];
//      order.notify_url = [dic objectForKey:@"notify_url"];
//      order.service = [dic objectForKey:@"service"];
//      order.payment_type = [dic objectForKey:@"payment_type"];
//      order._input_charset = [dic objectForKey:@"_input_charset"];
//      order.sign = [dic objectForKey:@"sign"];
//      order.sign_type = [dic objectForKey:@"sign_type"];
//      
//      //将商品信息拼接成字符串
//      NSString *orderSpec = [order description];
//      NSLog(@"orderSpec = %@",orderSpec);
//      
//      [[AlipaySDK defaultService] payOrder:orderSpec fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//      }];
//      
//    }
//  }];
//  
//  [dataTask resume];
//  
}

#pragma mark - < action >

- (IBAction)paybtntap:(id)sender{
  
}

-(IBAction)rsaPayBtnTap:(id)sender{
  [self alipay_old_rsa];
}

- (IBAction)webbtnTap:(id)sender{
  [self alipay_old_tpagesTest];
}

#pragma mark - < callback >
//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//  NSString *host = request.URL.host;
//  NSString *relativePath = request.URL.relativePath;
//  NSString *query = request.URL.query;
//  NSArray *params = [query componentsSeparatedByString:@"&"];
//  NSString *firstParam = params[0];
//  NSLog(@"~~~ %@ %@ %@",host,relativePath,firstParam);
//  
//  if ([host isEqualToString:@"mall.tpages.cn"] && [relativePath isEqualToString:@"/index.php"] && [firstParam isEqualToString:@"app=cashier"]) {
//    NSLog(@"url:%@",request.URL.absoluteString);
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    operation.securityPolicy.allowInvalidCertificates = YES;
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//      NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//      NSError *error;
//      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//      NSLog(@"dic:%@",dic);
//      
//      NSString *status = [dic objectForKey:@"status"];
//      if ([status isEqualToString:@"success"]) {
//
//      }
//      
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//      NSLog(@"weblogin failuer :%@",error);
//      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&error];
//      NSString *str = [dic objectForKey:@"message"];
//      str = [str stringByRemovingPercentEncoding];
//    }];
//    [[NSOperationQueue mainQueue] addOperations:@[operation] waitUntilFinished:NO];
//    return NO;
//  }
//  
//  return YES;
//
//}


@end
