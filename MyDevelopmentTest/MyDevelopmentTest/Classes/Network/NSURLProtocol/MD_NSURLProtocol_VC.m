//
//  MD_NSURLProtocol_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSURLProtocol_VC.h"
#import "CustomURLProtocol.h"
@interface MD_NSURLProtocol_VC ()

@end
@implementation MD_NSURLProtocol_VC

-(void)viewDidLoad{

  [super viewDidLoad];
  
  [NSURLProtocol registerClass:[CustomURLProtocol class]];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self commonInitUI];
}

-(void)commonInitUI{

  UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:webview];
  
  [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}
@end
