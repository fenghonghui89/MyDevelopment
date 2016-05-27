//
//  MD_WebKit_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/5/19.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

@import WebKit;
#import "MD_WebKit_VC.h"
#import "CustomURLCache.h"

@interface MD_WebKit_VC ()
<
WKNavigationDelegate,
WKScriptMessageHandler
>
@property(nonatomic,strong)WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *webViewBgView;
@end

@implementation MD_WebKit_VC

#pragma mark - < vc lifecycle >

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  [self commonInitUI1];
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

-(void)commonInitUI1{
  
  CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                               diskCapacity:200 * 1024 * 1024
                                                                   diskPath:nil
                                                                  cacheTime:0];
  [CustomURLCache setSharedURLCache:urlCache];//缓存无效
  
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.webViewBgView.bounds];
  webView.navigationDelegate = self;
  [self.webViewBgView addSubview:webView];
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

//finish
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
  NSLog(@"didFinishNavigation");
  

}

//fail
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
  NSLog(@"didFailNavigation");
}

//
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
  
  NSLog(@"decidePolicyForNavigationAction");
  if (navigationAction.navigationType == WKNavigationTypeLinkActivated && ![navigationAction.request.URL.host.lowercaseString isEqualToString:@"www.baidu.com"]) {
    [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    decisionHandler(WKNavigationActionPolicyCancel);
  }else{
    decisionHandler(WKNavigationActionPolicyAllow);
  }
}

#pragma mark WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

  NSString *str = message.body;
  NSLog(@"str:%@",str);
}

@end
