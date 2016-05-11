//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_FreeTest_VC.h"

@interface MD_FreeTest_VC ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation MD_FreeTest_VC
#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
  self.webView.userInteractionEnabled = YES;
  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
  [self.view addSubview:self.webView];
  
  UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
  swipeGR.direction = UISwipeGestureRecognizerDirectionRight;
  swipeGR.delegate = self;
  [self.webView addGestureRecognizer:swipeGR];
}

#pragma mark - < method > -

-(void)customInitUI{
  
}

#pragma mark - < action > -
-(void)swipe:(UISwipeGestureRecognizer *)g{
  NSLog(@"~~~");

  [self.webView goBack];
}
#pragma mark - < callback > -
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  return YES;
}
@end
