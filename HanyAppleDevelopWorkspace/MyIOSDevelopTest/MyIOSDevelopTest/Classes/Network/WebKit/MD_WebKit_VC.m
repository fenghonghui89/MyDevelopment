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
    [self commonInitUI0];
}
#pragma mark - < method >

-(void)commonInitUI0{
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.webViewBgView.bounds];
    webView.navigationDelegate = self;
    [self.webViewBgView addSubview:webView];
    self.webView = webView;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://oc.123go.net.cn/modded/"]]];
    
}

-(void)commonInitUI1{
    
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

-(void)commonInitUI2{
    
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                 diskCapacity:200 * 1024 * 1024
                                                                     diskPath:nil
                                                                    cacheTime:0];
    [CustomURLCache setSharedURLCache:urlCache];//缓存无效
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    //  config.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
    //  WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    //
    //  [dataStore fetchDataRecordsOfTypes:[NSSet setWithObject:WKWebsiteDataTypeCookies] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull result) {
    //    NSLog(@"%@",result);
    //  }];
    
    //  WKWebView * webView = /*set up your webView*/
    //  NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://example.com/index.html"]];
    //  [request addValue:@"TeskCookieKey1=TeskCookieValue1;TeskCookieKey2=TeskCookieValue2;" forHTTPHeaderField:@"Cookie"];
    //  // use stringWithFormat: in the above line to inject your values programmatically
    //  [webView loadRequest:request];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.webViewBgView.bounds];
    webView.navigationDelegate = self;
    [self.webViewBgView addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tpages.cn"]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tpages.cn"]]];
    self.webView = webView;
    
}
#pragma mark - < action >

- (IBAction)btnTap:(id)sender {
    
    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    
    [dataStore fetchDataRecordsOfTypes:[NSSet setWithObject:WKWebsiteDataTypeCookies] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull result) {
        NSLog(@"%@",result);
    }];
}

- (IBAction)btnTap1:(id)sender {
    
    [self.webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mall.tpages.cn"]]];
}
#pragma mark - < callback >
#pragma mark WKNavigationDelegate
//准备加载页面
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation...");
}

/*
 已开始加载页面，可以在这一步向view中添加一个过渡动画
 也就是在页面内容加载到达mainFrame时会回调此API。如果我们要在mainFrame中注入什么JS，也可以在此处添加
 */
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation...");
}

/*
 页面已全部加载，可以在这一步把过渡动画去掉
 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation...");
    //  NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    //  NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    //
    //  for (NSHTTPCookie *cookie in cookies) {
    //    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //  }
    //
    //  decisionHandler(WKNavigationResponsePolicyAllow);
    
}

/*
 fail
 */
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailNavigation...%@",error.localizedDescription);
}


-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailProvisionalNavigation...%@",error.localizedDescription);
}

/*
 是否允许跳转 类似shouldStart
 */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"decidePolicyForNavigationAction...");
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && ![navigationAction.request.URL.host.lowercaseString isEqualToString:@"www.baidu.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/*
 请求https页面用
 */
-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    NSLog(@"didReceiveAuthenticationChallenge...");
    NSURLCredential *cred = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
}

#pragma mark WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"userContentController...:%@",message.body);
}



@end
