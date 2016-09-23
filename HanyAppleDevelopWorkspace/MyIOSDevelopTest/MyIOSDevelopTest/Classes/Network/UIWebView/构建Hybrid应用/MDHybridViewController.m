//
//  MDHybridViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDHybridViewController.h"
#import "NSString+URLEncoding.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface MDHybridViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation MDHybridViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self commonInitUI];

}

#pragma mark - method
-(void)commonInitUI{
  
  UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  webView.delegate = self;
  [self.view addSubview:webView];
  self.webView = webView;
  
//  NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"indexJS" ofType:@"html"];
//  NSURL *htmlURL = [NSURL fileURLWithPath:htmlPath];
  NSURL *htmlURL = [NSURL URLWithString:@"http://mall.local.dev.tpages.com"];
  NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
  [webView loadRequest:request];
}

#pragma mark - action
-(void)method_JSToOC{
  
  JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  
  //关联打印异常
  context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
    context.exception = exceptionValue;
    NSLog(@"异常信息：%@", exceptionValue);
  };
  
//  context[@"hanyLog"] = ^() {
//    
//    NSLog(@"+++++++Begin Log+++++++");
//    NSArray *args = [JSContext currentArguments];
//    
//    for (JSValue *jsVal in args) {
//      NSLog(@"%@", jsVal);
//    }
//    
//    JSValue *this = [JSContext currentThis];
//    NSLog(@"this: %@",this);
//    NSLog(@"-------End Log-------");
//    
//  };
  
  //注入js
  NSString *alertJS = @"alert('test js OC')";
  [context evaluateScript:alertJS];
}

#pragma mark - callback
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  
  /*
   html中的界面跳转被触发时，会加载新界面，就会调用该方法
   */
  
  NSString *requestStr = [request.URL absoluteString];
  NSString *scheme = request.URL.scheme;
  NSString *host = request.URL.host;
  NSString *fragment = [request.URL.fragment URLDecodedString];//用NSString分类里的方法解码
  NSData *data = [fragment dataUsingEncoding:NSUTF8StringEncoding];
  
  NSLog(@"~~~ 1:%@ 2:%@",requestStr,fragment);
  if ([scheme isEqualToString:@"gap"]) {
    if ([host isEqualToString:@"TPagesApp.Share"]) {
      NSError *error = nil;
      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
      NSLog(@"title: %@ , message: %@",[dic objectForKey:@"title"], [dic objectForKey:@"message"] );
      
    }
  }
  
  return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
  
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  NSLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
  
  NSLog(@"webViewDidFinishLoad");
  [self method_JSToOC];
  //使用本地代码调用js函数helloWorld(msg)
  [self.webView stringByEvaluatingJavaScriptFromString:@"helloWorld('从iOS对象中调用JS Ok.')"];
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  
  NSLog(@"didFailLoadWithError");
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
@end
