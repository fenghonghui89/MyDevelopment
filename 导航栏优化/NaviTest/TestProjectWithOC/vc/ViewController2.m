//
//  ViewController2.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3_0.h"
#import "XTJNavigationItem_Main.h"
#import "XANavBarTransition.h"
@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //navi
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    homeBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"爆款推荐";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.navigationController.navigationBar.barTintColor = HexColor(@"934d91");
    
    
    self.navigationItem.hidesBackButton = YES;
    
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

/*
 MARK:UI
 从不透明右滑变回透明会有延迟，所以要提前变透明
 */
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navBarBgAlpha = 0;
//}

- (IBAction)tap:(id)sender {
    ViewController3_0 *vc = [[ViewController3_0 alloc] initWithNibName:@"ViewController3_0" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
