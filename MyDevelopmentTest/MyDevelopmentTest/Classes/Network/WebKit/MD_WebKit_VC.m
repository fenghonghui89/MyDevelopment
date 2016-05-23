//
//  MD_WebKit_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/5/19.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_WebKit_VC.h"
@import WebKit;

@interface MD_WebKit_VC ()
<
WKNavigationDelegate,
WKScriptMessageHandler
>
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation MD_WebKit_VC

#pragma mark - < vc lifecycle >

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  [self commonInitUI];
}
#pragma mark - < method >

-(void)commonInitUI{

  NSString *js = @"window.webkit.messageHandlers.observe.postMessage(document.body.innerText);";
  WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
  WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
  [config.userContentController addUserScript:script];
  [config.userContentController addScriptMessageHandler:self name:@"observe"];
  
  WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH) configuration:config];
  webView.navigationDelegate = self;
  [self.view addSubview:webView];
  
  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

#pragma mark - < action >
#pragma mark - < callback >
#pragma mark WKNavigationDelegate
//相当于shouldStart
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
  NSLog(@"didStartProvisionalNavigation");
}

//相当于didStart
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
  NSLog(@"didCommitNavigation");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
  NSLog(@"didFinishNavigation");
  

}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
  NSLog(@"didFailNavigation");
}

#pragma mark WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

  NSString *str = message.body;
  NSLog(@"str:%@",str);
}
@end
