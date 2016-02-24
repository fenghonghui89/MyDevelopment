//
//  ViewController.m
//  MallTest
//
//  Created by 冯鸿辉 on 16/2/23.
//  Copyright © 2016年 DGC. All rights reserved.
//
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#import "ViewController.h"
#import "DGCCustomBarButton.h"
#import <Cordova/CDVViewController.h>
@interface ViewController ()
@property(nonatomic,strong)CDVViewController *vc;
@end

@implementation ViewController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
  [self.navigationController setToolbarHidden:NO animated:YES];
  [self customInitUI];
}

#pragma mark - < method > -
#pragma mark custom init
-(void)customInitUI{
  [self customInitCordovaView];
  //  [self customInitWebView];
  [self customInitStatusBar];
  [self customInitNaviBar];
  [self customInitToolBar];
}

-(void)customInitWebView{
  UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
  tempWebView.scalesPageToFit = YES;
  tempWebView.userInteractionEnabled = YES;
  tempWebView.backgroundColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:0.5];
  [self.view addSubview:tempWebView];
  
  NSURL *url = [NSURL URLWithString:@"http://dev.123go.net.cn/portal.php"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [tempWebView loadRequest:request];
}

-(void)customInitToolBar
{
  //分享
  UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
  
  //第三方登录
  UIBarButtonItem *thirdLoginBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(thirdLogin)];
  
  //后退
  UIBarButtonItem *barBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                           target:self
                                                                           action:@selector(netBack)];
  //收藏
  UIBarButtonItem *barSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                           target:self
                                                                           action:@selector(netSave)];
  //恢复
  UIBarButtonItem *barReset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                            target:self
                                                                            action:@selector(netReset)];
  //拉宽
  UIBarButtonItem *barSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:self
                                                                            action:nil];
  
  //第三方
  UIBarButtonItem *barThridSDK = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(thridSDKAction)];
  
  //设置二维码生成与扫描
  UIButton *QR = [UIButton buttonWithType:UIButtonTypeCustom];
  [QR setBackgroundImage:[UIImage imageNamed:@"QR"]
                forState:UIControlStateNormal];
  [QR addTarget:self action:@selector(createQR) forControlEvents:UIControlEventTouchUpInside];
  QR.frame = CGRectMake(0, 0, 20, 20);
  UIBarButtonItem *barQRButton = [[UIBarButtonItem alloc] initWithCustomView:QR];
  
  UIButton *searchQR = [UIButton buttonWithType:UIButtonTypeCustom];
  [searchQR setBackgroundImage:[UIImage imageNamed:@"QRSearch"] forState:UIControlStateNormal];
  [searchQR addTarget:self action:@selector(searchQR) forControlEvents:UIControlEventTouchUpInside];
  searchQR.frame = CGRectMake(0, 0, 20, 20);
  UIBarButtonItem *barSearchQRButton = [[UIBarButtonItem alloc] initWithCustomView:searchQR];
  
  //临时按钮
  UIBarButtonItem *tempSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                             target:self
                                                                             action:@selector(tempCheck)];
  
  [self setToolbarItems:@[shareBtn,thirdLoginBtn,barBack, tempSpace, barSpace, barThridSDK, barSearchQRButton, barQRButton, barSave, barReset] animated:YES];
}

-(void)customInitCordovaView{
  CDVViewController *vc = [[CDVViewController alloc] init];
  vc.wwwFolderName = @"www";
  vc.view.frame = CGRectMake(0, 20, screenW, screenH-20);
  [self.view addSubview:vc.view];
  self.vc = vc;
}

-(void)customInitStatusBar{
  UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
  statusBarView.backgroundColor=[UIColor blackColor];
  statusBarView.tag = 101;
  statusBarView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:statusBarView];
}

-(void)customInitNaviBar{
  UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
  [customNavigationBar setBackgroundImage:[UIImage imageNamed:@"320x44.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
  customNavigationBar.tag = 103;
  [self.view addSubview:customNavigationBar];
  
  UINavigationItem *navigationItemView = [[UINavigationItem alloc] init];
  UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navilogo.png"]];
  iv.contentMode = UIViewContentModeScaleAspectFit;
  iv.userInteractionEnabled  = YES;
  [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topCenterTap:)]];
  navigationItemView.titleView = iv;
  
  
  DGCCustomBarButton *menuBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
  [menuBtn setFrame:CGRectMake(0, 0, 44, 44)];
  [menuBtn.imageView setImage:[UIImage imageNamed:@"title_menu.png"]];
  [menuBtn.btn addTarget:self action:@selector(menuItemTap) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
  menuItem.enabled = YES;
  
  DGCCustomBarButton *backBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
  [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
  [backBtn.imageView setImage:[UIImage imageNamed:@"bar_back.png"]];
  [backBtn.btn addTarget:self action:@selector(netBack) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *barkItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
  barkItem.enabled = YES;
  
  navigationItemView.leftBarButtonItems = @[menuItem,barkItem];
  
  DGCCustomBarButton *searchBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
  [searchBtn setFrame:CGRectMake(0, 0, 44, 44)];
  [searchBtn.imageView setImage:[UIImage imageNamed:@"icon_search.png"]];
  [searchBtn.btn addTarget:self action:@selector(searchItemTap) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
  searchItem.enabled = YES;
  
  DGCCustomBarButton *personalBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
  [personalBtn setFrame:CGRectMake(0, 0, 44, 44)];
  [personalBtn.imageView setImage:[UIImage imageNamed:@"login.png"]];
  [personalBtn.btn addTarget:self action:@selector(personalItemTap) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *personalItem = [[UIBarButtonItem alloc] initWithCustomView:personalBtn];
  personalItem.enabled = YES;
  
  navigationItemView.rightBarButtonItems = @[personalItem,searchItem];
  
  [customNavigationBar pushNavigationItem:navigationItemView animated:NO];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}
@end
