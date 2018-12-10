//
//  HFViewController.m
//  test
//
//  Created by hanyfeng on 14-5-5.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"

@interface HFViewController ()
@property(nonatomic,strong)UIButton *btn;
@end

@implementation HFViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

-(void)tap{
    HFSecondView *sv = [[HFSecondView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:sv atIndex:1000];//对旋屏有影响
    [sv showViewInRight];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect frame = CGRectZero;
    frame = self.btn.frame;
    frame = CGRectMake(self.view.bounds.size.width - (self.view.bounds.size.width - 100) / 2 - 100, 50, 100, 30);
    self.btn.frame = frame;
}

#pragma mark - 旋屏开关 -
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
