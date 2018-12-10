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
@interface ViewController3_0 ()

@end

@implementation ViewController3_0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customInitNavigationBar];
    [self customInitView];
}

-(void)customInitNavigationBar{
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"透明导航栏";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.xa_navBarAlpha = 0;
}

-(void)customInitView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)tap:(id)sender {
   
}

@end
