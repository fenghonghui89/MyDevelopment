//
//  ViewController.m
//  AliPayTest
//
//  Created by 冯鸿辉 on 16/1/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#define appScheme @"hanyalipaytest"

#import "ViewController.h"
#import "DataSigner.h"
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
  
//  self.webview.delegate = self;
//  NSURL *url = [NSURL URLWithString:@"http://mall.tpages.cn"];
//  NSURLRequest *req = [NSURLRequest requestWithURL:url];
//  [self.webview loadRequest:req];
}

#pragma mark - < callback > -
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  NSString *host = request.URL.host;
  NSString *relativePath = request.URL.relativePath;
  NSString *query = request.URL.query;
  NSArray *params = [query componentsSeparatedByString:@"&"];
  NSString *firstParam = params[0];
  NSLog(@"~~~ %@ %@ %@",host,relativePath,firstParam);
  
  if ([host isEqualToString:@"mall.tpages.cn"] && [relativePath isEqualToString:@"/index.php"] && [firstParam isEqualToString:@"app=cashier"]) {
    NSLog(@"url:%@",request.URL.absoluteString);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    operation.securityPolicy.allowInvalidCertificates = YES;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
      NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      NSError *error;
      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
      NSLog(@"dic:%@",dic);
      
      NSString *status = [dic objectForKey:@"status"];
      if ([status isEqualToString:@"success"]) {

      }
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"weblogin failuer :%@",error);
      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&error];
      NSString *str = [dic objectForKey:@"message"];
      str = [str stringByRemovingPercentEncoding];
    }];
    [[NSOperationQueue mainQueue] addOperations:@[operation] waitUntilFinished:NO];
    return NO;
  }
  
  return YES;

}

#pragma mark - < action > -

- (IBAction)paybtntap:(id)sender
{
  Order *order = [[Order alloc] init];
  order.partner = @"2088021590285844";
  order.seller_id = @"tat_pay@tpages.com";
  order.out_trade_no = @"1601077488";
  order.subject = @"\u8ba2\u5355\u53f7:1601077488";
  order.body = @"\u8ba2\u5355\u53f7:1601077488";
  order.total_fee = @"0.01";
  order.notify_url = @"http://mall.local.dev.tpages.com/alipaywapcb";
  order.service = @"mobile.securitypay.pay";
  order.payment_type = @"1";
  order._input_charset = @"utf-8";
  order.sign = @"qLbgdBGNerS4qrfCqWLw0pRo114sb2XZ%2BQsbXqRNlbJIDFNIwT5gK3yjVAUT6Ui403LWfcmkUAt1FgCK3ojBvVS9EjVjJulKTXuQ0QT9RkbMuBySHkmRel87wyFaHt9jvIgeZ1YlRunQjaPI5PMKUSLqHxB0ouBs%2BCTVJbmdSF0%3D";
  order.sign_type = @"RSA";
  
  //将商品信息拼接成字符串
  NSString *orderSpec = [order description];
  NSLog(@"orderSpec = %@",orderSpec);
  
  [[AlipaySDK defaultService] payOrder:orderSpec fromScheme:appScheme callback:^(NSDictionary *resultDic) {
    NSLog(@"reslut = %@",resultDic);
  }];
}
- (IBAction)rsaPayBtnTap:(id)sender
{
  NSString *partner = @"2088021590285844";
  NSString *seller = @"tat_pay@tpages.com";
  NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALjgQC6rWplJUj4g0G4zWjseZiDuRJZUBq+ity+kZKM0tvPyuPpSvw444zc9Tqw9mBGup7S8Y2fCyfV5B68tG7Sl4WkHhTP9EnNQuKndHkMBOOWhr/DixHQ/nBNcx1KBrMwXcegCqMWs9uJEuKYq37kVdh9QSYDxN5TLhs40lUn/AgMBAAECgYEAp/s61izkWTuB+umd+UO3zNfGPE3DDES0/ol+oU9iEdkoE2iMIwdkieuuqNaP0Xj137surs4uFG2tS9n43XbDIEngwTmR8sC+Y1IGL981WGLTj9oRPcN+wj52A/MAQqZQZG+8sPa4aQzUnGV7C7mv6O/0c9UDkAEyl6A87NhHHuECQQDdawd42dWNvL0xsQDw187qqIA0F7ljQk3vOQaxhx19Qwo4PtqkoOZ3wySIIS257IpnAYd6fs2qblocUaeqlQMlAkEA1cAoHKl+PH92qljekbKRWviGYuBspf3ECEydgh3Xi3WGX1c642GngQNYgsNiaOLwFnyOTVero1v6aPVvFa+hUwJBAMsAc+tTHL5EitliRVCLLARs1I3uKmRcyANKL17YWCseKeKDjgZeFq861OWSNdA+lG34MvQWCg31+tv36Vc2I5kCQGovfH3IoaKSO7QiU+cTS2xi2/fQv4iyiSkKTpDuHD72kltYrTN6Nsk7jUPgpkmuu1Cgbdz0OZr8vWhYzOd8CWsCQQCbXQGJdC0kKC4A30qzRMmxK445lBrtFuULvrrt9pBdGqNumt8Ng/gNuH7Xef0ffzzeq4q1LEsHJC5i+0JDh+Aw";//pkcs8格式私钥，把头尾和换行去掉
  
  Order *order = [[Order alloc] init];
  order.partner = partner;
  order.seller_id = seller;
  order.out_trade_no = @"1601077488";
  order.subject = @"\u8ba2\u5355\u53f7:1601077488";
  order.body = @"\u8ba2\u5355\u53f7:1601077488";
  order.total_fee = @"0.01";
  order.notify_url = @"http://mall.local.dev.tpages.com/alipaywapcb";
  order.service = @"mobile.securitypay.pay";
  order.payment_type = @"1";
  order._input_charset = @"utf-8";

  //将商品信息拼接成字符串
  NSString *orderSpec = [order description];
  NSLog(@"orderSpec = %@",orderSpec);
  
  //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
  id<DataSigner> signer = CreateRSADataSigner(privateKey);
  NSString *signedString = [signer signString:orderSpec];
  
  //将签名成功字符串格式化为订单字符串,请严格按照该格式
  NSString *orderString = nil;
  if (signedString != nil) {
    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                   orderSpec, signedString, @"RSA"];
    NSLog(@"orderStr: %@",orderString);
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
      NSLog(@"pay reslut = %@",resultDic);
    }];
  }

}

@end
