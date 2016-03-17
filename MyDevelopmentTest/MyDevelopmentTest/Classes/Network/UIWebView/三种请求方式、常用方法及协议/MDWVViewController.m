//
//  MDWVViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDWVViewController.h"

@interface MDWVViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MDWVViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //开启状态栏动画
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
  self.webView.scalesPageToFit = YES;//设置为YES则网页内容自适应webview大小，且用户可以用手势来放大或者缩小页面
}

#pragma mark - action
- (IBAction)tap1:(id)sender
{
  //1.读取html文件
  //取得html文件的路径，把html文件的内容读取到NSString对象中
  NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
  NSError *error = nil;
  NSString *htmlString = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
  
  //2.把html文件的基本路径，即所在的资源目录，转成url
  NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
  NSURL *bundleUrl = [NSURL fileURLWithPath:bundlePath];
  
  //3.读取内容，显示到webview
  if (error == nil) {
    [self.webView loadHTMLString:htmlString baseURL:bundleUrl];
  }
}

- (IBAction)tap2:(id)sender
{
  //1.读取html文件
  //取得html文件的路径，把html文件的内容读取到NSData对象中
  NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
  NSData *htmlData = [[NSData alloc] initWithContentsOfFile:htmlPath];
  
  //2.把html文件的基本路径，即所在的资源目录，转成url
  NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
  NSURL *bundleUrl = [NSURL fileURLWithPath:bundlePath];
  
  //3.读取内容，显示到webview
  NSError *error = nil;
  if (error == nil) {
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL: bundleUrl];
  }
}

- (IBAction)tap3:(id)sender
{
  self.webView.delegate = self;
  
  NSString *path = @"http://mall.tpages.cn";//不能忽略协议名http://
  NSURL *url = [NSURL URLWithString:path];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:urlRequest];
}

- (IBAction)lastPage:(id)sender
{
  [self.webView goBack];
}

- (IBAction)nextPage:(id)sender
{
  [self.webView goForward];
}

- (IBAction)refresh:(id)sender
{
  [self.webView reload];
}

- (IBAction)stop:(id)sender
{
  [self.webView stopLoading];
}

#pragma mark - callback
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  NSLog(@"1");
  return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
  NSLog(@"2");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  NSLog(@"3");
  
  //调用js语句；获得页面中html代码的js语句
  NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  NSLog(@"4");
}
@end
