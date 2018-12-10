//
//  ViewController4.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/20.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController4.h"
#import "XTJNavigationItem_Main.h"
#import "ScrollPageVC.h"
@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self customInitNavigationBar];
    [self customInitView];
}

-(void)customInitNavigationBar{
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"新品热销";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.xa_navBarAlpha = 1;
}

-(void)customInitView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)tap:(id)sender {
    ScrollPageVC *vc = [[ScrollPageVC alloc] initWithNibName:@"ScrollPageVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
