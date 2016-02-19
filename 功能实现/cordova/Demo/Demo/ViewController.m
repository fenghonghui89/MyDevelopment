//
//  ViewController.m
//  Demo
//
//  Created by 冯鸿辉 on 16/2/19.
//  Copyright © 2016年 DGC. All rights reserved.
//

#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#import "ViewController.h"
#import "ViewController1.h"
@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
  self.view.backgroundColor = [UIColor orangeColor];
//  [self customInitWebView];
//  [self customInitStateBar];
  UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  [btn setBackgroundColor:[UIColor redColor]];
  [self.view addSubview:btn];
  [btn addTarget:self action:@selector(btntap) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btntap{
  ViewController1 *vc = [ViewController1 new];
  vc.wwwFolderName = @"mywww";
  vc.startPage = @"my.html";
  [self.navigationController pushViewController:vc animated:YES];
}

-(void)customInitWebView{
  UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
  tempWebView.scalesPageToFit = YES;
  tempWebView.userInteractionEnabled = YES;
  tempWebView.delegate = self;
  tempWebView.backgroundColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:0.5];
  [self.view addSubview:tempWebView];
  self.webview = tempWebView;

  NSURL *url = [NSURL URLWithString:@"http://dev.123go.net.cn/portal.php"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [tempWebView loadRequest:request];
}

-(void)customInitStateBar{
  UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
  statusBarView.backgroundColor=[UIColor blackColor];
  statusBarView.tag = 101;
  statusBarView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:statusBarView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

@end
