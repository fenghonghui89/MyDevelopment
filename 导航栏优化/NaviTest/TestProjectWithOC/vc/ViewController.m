//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1_0.h"
#import "XTJRootDefine.h"
#import "Masonry.h"
#import "XTJNavigationItem_Home.h"
#import "XANavBarTransition.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //navi
    self.view.backgroundColor = [UIColor redColor];
    
    XTJNavigationItem_Home *homeBar = [XTJNavigationItem_Home loadNibWithOwner:self];
    homeBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = homeBar;
    
    self.navigationController.navigationBar.barTintColor = HexColor(@"934d91");
    
    self.xa_navBarAlpha = 1;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navBarBgAlpha = 1;
//}
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navBarBgAlpha = 1;
//}

- (IBAction)tap:(id)sender {
    ViewController1_0 *vc = [[ViewController1_0 alloc] initWithNibName:@"ViewController1_0" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)customInitNaviBar{
//
//    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navibg.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//    [self.view addSubview:bar];
//
//
//    UINavigationItem *item = [[UINavigationItem alloc] init];
//}
//
//-(void)customInitNaviBar_{
//
//    UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
//    [customNavigationBar setBackgroundImage:[UIImage imageNamed:@"navibg.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//    customNavigationBar.tag = 103;
//    [self.view addSubview:customNavigationBar];
//
//    UINavigationItem *navigationItemView = [[UINavigationItem alloc] init];
//    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW*0.33, 44)];
//    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
//    [titleBgView addSubview:iv];
//    iv.contentMode = UIViewContentModeScaleAspectFit;
//    iv.userInteractionEnabled  = YES;
//    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topCenterTap:)]];
//
//    iv.translatesAutoresizingMaskIntoConstraints = NO;
//    NSString *expression = nil;
//    NSDictionary *dic = NSDictionaryOfVariableBindings(iv);
//    expression = @"|-0-[iv]-0-|";
//    NSArray *hc = [NSLayoutConstraint constraintsWithVisualFormat:expression options:NSLayoutFormatAlignAllCenterY metrics:0 views:dic];
//    [titleBgView addConstraints:hc];
//    expression = @"V:|-(-5)-[iv]-5-|";
//    NSArray *vc = [NSLayoutConstraint constraintsWithVisualFormat:expression options:NSLayoutFormatAlignAllCenterX metrics:0 views:dic];
//    [titleBgView addConstraints:vc];
//
//    navigationItemView.titleView = titleBgView;
//
//
//    DGCCustomBarButton *menuBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
//    [menuBtn setFrame:CGRectMake(0, 0, 44, 44)];
//    [menuBtn.imageView setImage:[UIImage imageNamed:@"menu.png"]];
//    [menuBtn.btn addTarget:self action:@selector(menuItemTap) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    [menuBtn setFrame:CGRectMake(0, 0, 44, 44)];
//    menuItem.enabled = YES;
//
//    DGCCustomBarButton *backBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
//    [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
//    [backBtn.imageView setImage:[UIImage imageNamed:@"back.png"]];
//    [backBtn.btn addTarget:self action:@selector(netBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barkItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    barkItem.enabled = YES;
//
//    navigationItemView.leftBarButtonItems = @[menuItem,barkItem];
//
//    DGCCustomBarButton *searchBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
//    [searchBtn setFrame:CGRectMake(0, 0, 44, 44)];
//    [searchBtn.imageView setImage:[UIImage imageNamed:@"search.png"]];
//    [searchBtn.btn addTarget:self action:@selector(searchItemTap) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
//    searchItem.enabled = YES;
//
//    DGCCustomBarButton *personalBtn = [[[NSBundle mainBundle] loadNibNamed:@"DGCCustomBarButton" owner:self options:nil] lastObject];
//    [personalBtn setFrame:CGRectMake(0, 0, 44, 44)];
//    [personalBtn.imageView setImage:[UIImage imageNamed:@"login.png"]];
//    [personalBtn.btn addTarget:self action:@selector(personalItemTap) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *personalItem = [[UIBarButtonItem alloc] initWithCustomView:personalBtn];
//    personalItem.enabled = YES;
//    personBtn = personalBtn;
//    navigationItemView.rightBarButtonItems = @[personalItem,searchItem];
//
//    [customNavigationBar pushNavigationItem:navigationItemView animated:NO];
//}

@end
