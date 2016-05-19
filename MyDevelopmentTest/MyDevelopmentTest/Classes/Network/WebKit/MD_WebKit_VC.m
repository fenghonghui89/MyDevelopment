//
//  MD_WebKit_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/5/19.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_WebKit_VC.h"
@import WebKit;

@interface MD_WebKit_VC ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation MD_WebKit_VC

#pragma mark - < vc lifecycle >

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
}
#pragma mark - < method >

-(void)commonInitUI{

  WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
  webView.navigationDelegate = self;
  [self.view addSubview:webView];
  
  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}
#pragma mark - < action >
#pragma mark - < callback >
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
  NSLog(@"didStartProvisionalNavigation");
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
  NSLog(@"didCommitNavigation");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
  NSLog(@"didFinishNavigation");
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
  NSLog(@"didFailNavigation");
}
@end
