//
//  ViewController.m
//  wvtest
//
//  Created by 冯鸿辉 on 16/1/18.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview_sb;
@property (nonatomic,strong)NSURLCache *urlCache;
@property (nonatomic,strong)NSMutableURLRequest *request;
@property (nonatomic,assign)NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.count = 1;

}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self webload];
  [self loadCache];
}

-(void)webload{
  
  //为何这个不行
//  NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//  cachesPath = [cachesPath stringByAppendingString:@"/TpagesCacheDic"];
//  NSURLCache *urlcache = [[NSURLCache alloc] initWithMemoryCapacity:1*1024*1024 diskCapacity:1*1024*1024 diskPath:cachesPath];
//  [NSURLCache setSharedURLCache:urlcache];
//  self.urlCache = urlcache;
  
  NSURLCache *urlcache = [NSURLCache sharedURLCache];
  [urlcache setMemoryCapacity:1*1024*1024];
  self.urlCache = urlcache;
  
  NSURL *url = [NSURL URLWithString:@"http://tpages.cn/portal.php"];
//  NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
  self.request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
}
- (IBAction)btnTap:(id)sender {
  
}

-(void)loadCache{
  NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:self.request];
  if (response) {
    NSLog(@"找到缓存了");
    [self.request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    [self.webview_sb loadRequest:self.request];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"找到了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      [ac dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:ac animated:YES completion:nil];
  }else{
    if (self.count<20) {
      NSLog(@"还没找到缓存");
      self.count++;
      [self loadCache];
    }else{
      self.count = 1;
      NSLog(@"最后还是找不到缓存");
      [self.webview_sb loadRequest:self.request];
    }
  }
}

#pragma mark - callback
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  NSString *host = request.URL.host;
  NSString *relativePath = request.URL.relativePath;
  NSString *query = request.URL.query;
  NSArray *params = [query componentsSeparatedByString:@"&"];
  NSString *firstParam = params[0];
  NSLog(@"~~~ %@ %@ %@",host,relativePath,firstParam);
  return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//  [self.request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//  [self.request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
}



@end
