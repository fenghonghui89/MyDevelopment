//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController.h"

#import "XTJRootDefine.h"

#import "XTJNavigationItem_Home.h"

#import "ViewController1_0.h"
#import "ViewController4.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self customInitNavigationBar];
    [self customInitView];
}


#pragma mark - init
-(void)customInitNavigationBar{
    XTJNavigationItem_Home *homeBar = [XTJNavigationItem_Home loadNibWithOwner:self];
    self.navigationItem.titleView = homeBar;
    
    self.xa_navBarAlpha = 1;
}

-(void)customInitView{
    self.view.backgroundColor = [UIColor whiteColor];
}


- (IBAction)tap:(id)sender {
    ViewController1_0 *vc = [[ViewController1_0 alloc] initWithNibName:@"ViewController1_0" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)tap1:(id)sender {
    
    ViewController4 *vc = [[ViewController4 alloc] initWithNibName:@"ViewController4" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
