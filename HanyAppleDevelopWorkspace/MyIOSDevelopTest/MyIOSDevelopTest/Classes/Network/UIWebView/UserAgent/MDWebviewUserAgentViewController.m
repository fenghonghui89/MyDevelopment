//
//  MDWebviewUserAgentViewController.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 15/12/24.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import "MDWebviewUserAgentViewController.h"

@interface MDWebviewUserAgentViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,copy)NSString *userAgent;
@end

@implementation MDWebviewUserAgentViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  [self createHttpRequest];
}



- (void)createHttpRequest
{
  [self.webview setDelegate:self];
  [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
  NSLog(@"!!!%@", [self userAgentString]);
}

-(NSString *)userAgentString
{
  while (self.userAgent == nil)
  {
    NSLog(@"in while");
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
  }
  return self.userAgent;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  if (webView == _webview) {
    self.userAgent = [request valueForHTTPHeaderField:@"User-Agent"];
    NSLog(@"userAgent:%@",[request valueForHTTPHeaderField:@"User-Agent"]);
    return NO;
  }
  return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
