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
    
    [self customInitNavigationBar];
    [self customInitView];
}

-(void)customInitNavigationBar{
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    homeBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"订单生成页";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    
    self.xa_navBarAlpha = 1;
    self.xa_isPopEnable = NO;
}

-(void)customInitView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)tap:(id)sender {
    ViewController3_0 *vc = [[ViewController3_0 alloc] initWithNibName:@"ViewController3_0" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
