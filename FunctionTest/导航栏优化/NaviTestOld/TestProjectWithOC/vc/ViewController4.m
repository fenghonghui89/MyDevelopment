//
//  ViewController4.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/20.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController4.h"
#import "XTJNavigationItem_Main.h"
#import "XANavBarTransition.h"
@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //navi
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    homeBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"新品热销";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
//    self.navigationController.navigationBar.barTintColor = HexColor(@"934d91");
    self.navigationItem.hidesBackButton = YES;

    self.xa_navBarAlpha = 1;
}




@end
