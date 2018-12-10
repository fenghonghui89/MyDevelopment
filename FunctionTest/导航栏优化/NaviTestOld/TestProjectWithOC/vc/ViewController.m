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
//    self.navigationItem.hidesBackButton = YES;
    
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


@end
