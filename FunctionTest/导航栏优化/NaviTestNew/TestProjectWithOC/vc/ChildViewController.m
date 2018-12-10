//
//  ChildViewController.m
//  NaviTest2
//
//  Created by hanyfeng on 2018/11/12.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customInit];
}

-(void)customInit{
    [self customInitNavigationBar];
    [self customInitView];
}

-(void)customInitNavigationBar{
    
}

-(void)customInitView{
    self.view.backgroundColor = [UIColor randomColor];
}

- (IBAction)btnTap:(id)sender {
    NSLog(@"...%@",self.description);
}


@end
