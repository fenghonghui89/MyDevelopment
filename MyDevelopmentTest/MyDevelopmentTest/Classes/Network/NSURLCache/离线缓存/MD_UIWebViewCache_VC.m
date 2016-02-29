//
//  MD_UIWebViewCache_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UIWebViewCache_VC.h"

@interface MD_UIWebViewCache_VC ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSURLCache *urlCache;
@property (strong, nonatomic) NSMutableURLRequest *request;

@end

@implementation MD_UIWebViewCache_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self customInitUI];
}

#pragma mark - < method > -

-(void)customInitUI{
  
  NSURLCache *urlCache = [NSURLCache sharedURLCache];
  [urlCache setMemoryCapacity:1*1024*1024];
  self.urlCache = urlCache;
  
  NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
  NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
  self.request = request;
  
  [self.webView loadRequest:request];
  
  NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
  self.connection = newConnection;
}

#pragma mark - < action > -
- (IBAction)btnTap:(id)sender {
  
  //从请求中获取缓存输出,判断是否有缓存
  NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:self.request];

  if (response != nil){
    NSLog(@"如果有缓存输出，从缓存中获取数据");
    [self.request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
  }
  [self.webView loadRequest:self.request];
  
  NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
  self.connection = newConnection;
}
#pragma mark - < callback > -

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
  NSLog(@"即将发送请求");
  return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
  NSLog(@"将接收输出");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
  NSLog(@"接受数据 数据长度为 = %lu", (unsigned long)[data length]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
  NSLog(@"将缓存输出");
  return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  NSLog(@"请求完成");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
  NSLog(@"请求失败");
}
@end
