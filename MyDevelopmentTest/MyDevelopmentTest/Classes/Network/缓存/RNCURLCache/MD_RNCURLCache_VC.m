//
//  MD_RNCURLCache_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_RNCURLCache_VC.h"
#import "RNCachingURLProtocol.h"

@interface MD_RNCURLCache_VC ()

@end
@implementation MD_RNCURLCache_VC

#pragma mark - ************ override ************
#pragma mark - < vc lifecycle >
-(void)viewDidLoad{

  [super viewDidLoad];
  [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self commonInitUI];
}

#pragma mark - ************ method ************
-(void)commonInitUI{

  UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:webview];
  
  [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tpages.cn"]]];
}
@end
