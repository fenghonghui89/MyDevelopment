//
//  ViewController.m
//  WXPayTest
//
//  Created by 冯鸿辉 on 15/12/23.
//  Copyright © 2015年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "AFNetworking.h"
@interface ViewController ()<UIWebViewDelegate,WXApiManagerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,strong)NSDictionary *dic;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  NSURL *url = [NSURL URLWithString:@"http://mall.tpages.cn"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self.webview setDelegate:self];
  [self.webview loadRequest:request];
}



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
      self.dic = dic;
      NSLog(@"dic:%@",dic);
      
      NSString *status = [dic objectForKey:@"status"];
      if ([status isEqualToString:@"success"]) {
        [[WXApiManager sharedManager] setDelegate:self];
        [[WXApiManager sharedManager] jumpToBizPay:dic];
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

-(void)managerSuccess:(NSURL *)url
{
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self.webview loadRequest:request];
}

@end
