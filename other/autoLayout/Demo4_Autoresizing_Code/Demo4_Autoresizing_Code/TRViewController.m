//
//  TRViewController.m
//  Demo4_Autoresizing_Code
//
//  Created by Tarena on 13-11-22.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//例子1：
//    //1.用代码创建子view
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.backgroundColor = [UIColor blueColor];
//    
//    //2.先给出一个在当前父view下的正确的位置
//    button.frame = CGRectMake(20,20,self.view.bounds.size.width - 20 * 2,44);
//    NSLog(@"%f",self.view.bounds.size.width);
//    
//    //3.再设置autoresizingMask（指明在变化时，坐标如何改变）
//    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;//会改变的部分（可通过或运算符混合使用）：宽度-或运算符-下边框
 
//例子2：
    //1.用代码创建子view
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor blueColor];
    
    //2.先给出一个在当前父view下的正确的位置
    button.frame = CGRectMake(20,20,20,44);
    NSLog(@"%f",self.view.bounds.size.width);
    
    //3.再设置autoresizingMask（指明在变化时，坐标如何改变）
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
