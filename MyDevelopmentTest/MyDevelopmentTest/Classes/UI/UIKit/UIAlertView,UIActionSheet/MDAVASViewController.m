//
//  MDAVASViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDAVASViewController.h"

@interface MDAVASViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>

@end

@implementation MDAVASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [btn setTitle:@"alertview" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 110, 50, 50)];
    [btn1 setTitle:@"actionsheet" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

#pragma mark - action
-(void)tap
{
    UIAlertView* alertError =
    [[UIAlertView alloc]initWithTitle:@"警告"
                              message:@"密码错误"
                             delegate:self//1.委托方
                    cancelButtonTitle:@"确认"//下标为0
                    otherButtonTitles:@"A",@"B",nil];//下标为1、2...
    [alertError show];//显示方法
}

-(void)tap1
{
    UIActionSheet* actionSheet =
    [[UIActionSheet alloc]initWithTitle:@"警告"
                               delegate:self
                      cancelButtonTitle:@"确定"//0
                 destructiveButtonTitle:@"destructive"//3
                      otherButtonTitles:@"A",@"B", nil ];//1、2
    [actionSheet showInView:self.view];//注意显示方法和UIAlertView不同
}

#pragma mark - callback
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
}
@end
