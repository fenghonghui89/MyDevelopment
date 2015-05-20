//
//  MDHybridViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDHybridViewController.h"
#import "NSString+URLEncoding.h"
@interface MDHybridViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation MDHybridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *htmlURL = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [webView loadRequest:request];
}

#pragma mark - callback
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /*
     html中的界面跳转被触发时，会加载新界面，就会调用该方法
     */
    
    NSString *scheme = request.URL.scheme;
    NSString *host = request.URL.host;
    NSString *fragment = [request.URL.fragment URLDecodedString];//用NSString分类里的方法解码
    NSData *data = [fragment dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([scheme isEqualToString:@"gap"]) {
        if ([host isEqualToString:@"XXXClass.XXXmethod"]) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"title: %@ , message: %@",[dic objectForKey:@"title"], [dic objectForKey:@"message"] );
            
        }
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //使用本地代码调用js函数helloWorld(msg)
    [self.webView stringByEvaluatingJavaScriptFromString:@"helloWorld('从iOS对象中调用JS Ok.')"];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
@end
