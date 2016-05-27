//
//  MD_UIWebViewCache_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UIWebViewCache_VC.h"
#import "CustomURLCache.h"
@interface MD_UIWebViewCache_VC ()<NSURLConnectionDataDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSURLCache *urlCache;
@property (strong, nonatomic) NSMutableURLRequest *request;
@end

@implementation MD_UIWebViewCache_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self customInitUI0];
}

#pragma mark - < method > -

-(void)customInitUI0{

  CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
  [CustomURLCache setSharedURLCache:urlCache];
  
  NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:request];
  
}

-(void)customInitUI{
  
  NSURLCache *urlCache = [NSURLCache sharedURLCache];
  self.urlCache = urlCache;
  
  NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
  NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
  self.request = request;
  
//  [self.webView loadRequest:request];
  [self btnTap:nil];
  
//  NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
//  self.connection = newConnection;
}

#pragma mark - < action > -
- (IBAction)btnTap:(id)sender {
  //从请求中获取缓存输出,判断是否有缓存
  NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:self.request];
  if (response != nil){
    NSLog(@"有缓存");
    [self.request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
  }else{
    NSLog(@"没有缓存");
  }
  [self.webView loadRequest:self.request];
  
//  NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
//  self.connection = newConnection;
}
#pragma mark - < callback > -
#pragma mark NSURLConnectionDataDelegate
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

#pragma mark UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
  NSLog(@"~webViewDidFinishLoad");
//  [self.request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  NSLog(@"~didFailLoadWithError");
//  [self.request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
}
@end
