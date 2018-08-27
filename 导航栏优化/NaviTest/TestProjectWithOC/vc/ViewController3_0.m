//
//  ViewController3.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/20.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController3_0.h"
#import "XTJNavigationItem_Main.h"
#import "ViewController4.h"
#import "XANavBarTransition.h"
@interface ViewController3_0 ()

@end

@implementation ViewController3_0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //navi
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    homeBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"商品详情1";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.navigationController.navigationBar.barTintColor = HexColor(@"934d91");
    
    
    self.navigationItem.hidesBackButton = YES;
    
    self.xa_navBarAlpha = 0;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navBarBgAlpha = 0;
//}
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navBarBgAlpha = 0;
//}

- (IBAction)tap:(id)sender {
    ViewController4 *vc = [[ViewController4 alloc] initWithNibName:@"ViewController4" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
