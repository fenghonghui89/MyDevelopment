
//  ViewController.m
//  appA
//
//  Created by hanyfeng on 15/10/20.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "ViewController.h"
#import "NSString+URLEncoding.h"
@interface ViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *btnJumpBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myWebView.delegate = self;
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
    NSURL *htmlURL = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [self.myWebView loadRequest:request];
}

//使用本地代码调用js函数helloWorld(msg)
- (IBAction)tap:(id)sender
{
    [self.myWebView stringByEvaluatingJavaScriptFromString:@"helloWorld('ios层调用js层 ok')"];
}

//按钮跳转（可以用等号）
- (IBAction)btnJumpBtnTap:(id)sender
{
    NSString *paramStr = [NSString stringWithFormat:@"appB2://username=%@&age=%@&address=%@", @"Test123", @"100", @"上海市"];
//    NSString *paramStr = @"appB2://";
    NSURL *url = [NSURL URLWithString:[paramStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

//web直接跳转(app标识大写会转为小写，后面参数不会，不能用=&)
- (IBAction)webtap:(id)sender
{
    self.myWebView.delegate = self;
    NSString *str = @"appB2://Username-Test123_age-100_address-上海";
//    NSString *str = @"appB2://";
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];
}


#pragma mark - callback
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"me - shouldStartLoadWithRequest");
    
    /*
     html中的界面跳转被触发时，会加载新界面，就会调用该方法
     */
    
    NSString *scheme = request.URL.scheme;
    NSString *host = request.URL.host;
    NSString *fragment = [request.URL.fragment URLDecodedString];
    NSData *data = [fragment dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([scheme isEqualToString:@"gap"]) {
        if ([host isEqualToString:@"XXXClass.XXXmethod"]) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSString *str = [NSString stringWithFormat:@"title: %@ , message: %@",[dic objectForKey:@"title"], [dic objectForKey:@"message"]];
            NSLog(@"%@",str);
            [self.label setText:str];
        }
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"me - webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"me - webViewDidFinishLoad");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"me - didFailLoadWithError:%@",error.domain);
}
@end
