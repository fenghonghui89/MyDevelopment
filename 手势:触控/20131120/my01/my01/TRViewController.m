//
//  TRViewController.m
//  my01
//
//  Created by HanyFeng on 13-11-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.构建
	UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    //2.修改
    tapGR.numberOfTapsRequired = 2;//点击多少次才响应
    tapGR.numberOfTouchesRequired = 2;//多少个点同时触控才响应
    
    //3.加入
    [self.view addGestureRecognizer:tapGR];
}

//点击时输出信息
-(void)tap:(UITapGestureRecognizer*)sender
{
    NSLog(@"...");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
