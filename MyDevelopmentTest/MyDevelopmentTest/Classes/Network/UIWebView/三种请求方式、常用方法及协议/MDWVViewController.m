//
//  MDWVViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDWVViewController.h"

@interface MDWVViewController ()<UIWebViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

//请求https网站用
@property (assign,nonatomic) BOOL authenticated;
@property (nonatomic,strong) NSURLConnection *urlConnection;
@property (nonatomic,strong) NSURLRequest *request;
@end

@implementation MDWVViewController


#pragma mark - vc lifecycle


- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  self.webView.scalesPageToFit = YES;//设置为YES则网页内容自适应webview大小，且用户可以用手势来放大或者缩小页面
}

-(void)viewDidDisappear:(BOOL)animated{

  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
  [super viewDidDisappear:animated];
}

#pragma mark - action
- (IBAction)tap1:(id)sender{
  
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

- (IBAction)tap2:(id)sender{
  
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

- (IBAction)tap3:(id)sender{
  
  self.webView.delegate = self;
  
//  NSString *path = @"https://oc.123go.net.cn/modded/";//不能忽略协议名
  NSString *path = @"https://oc.123go.net.cn/modded/";//不能忽略协议名
  NSURL *url = [NSURL URLWithString:path];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  self.request = urlRequest;
  [self.webView loadRequest:urlRequest];
}

- (IBAction)lastPage:(id)sender{
  
  [self.webView goBack];
}

- (IBAction)nextPage:(id)sender{
  
  [self.webView goForward];
}

- (IBAction)refresh:(id)sender{
  
  [self.webView reload];
}

- (IBAction)stop:(id)sender{
  
  [self.webView stopLoading];
}

#pragma mark - callback
#pragma mark UIWebViewDelegate


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  

  NSLog(@"shouldStartLoadWithRequest...: %@ auth:%d", [[request URL] absoluteString], _authenticated);
  
  if (!_authenticated) {
    _authenticated = NO;
    _urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
    [_urlConnection start];
    
    return NO;
  }
  return YES;

}

-(void)webViewDidStartLoad:(UIWebView *)webView{
  
  NSLog(@"webViewDidStartLoad...");

  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
  
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
  NSLog(@"webViewDidFinishLoad...");
  
  //调用js语句；获得页面中html代码的js语句
  NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  
  NSLog(@"didFailLoadWithError... %@",error.localizedDescription);
  
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark NURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
  
  NSLog(@"WebController Got auth challange via NSURLConnection");
  
  if ([challenge previousFailureCount] == 0){
    _authenticated = YES;
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    
  }else{
    [[challenge sender] cancelAuthenticationChallenge:challenge];
  }
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
  
  NSLog(@"canAuthenticateAgainstProtectionSpace");
  return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
  NSLog(@"WebController received response via NSURLConnection");
  
  // emake a webview call now that authentication has passed ok.
  _authenticated = YES;
  [self.webView loadRequest:_request];
  
  // ancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
  [_urlConnection cancel];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
  NSLog(@"didReceiveData...：%lu",(unsigned long)data.length);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
  NSLog(@"connectionDidFinishLoading...");

}
@end
