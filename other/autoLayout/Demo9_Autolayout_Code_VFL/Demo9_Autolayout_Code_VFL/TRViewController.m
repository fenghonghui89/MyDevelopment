//
//  TRViewController.m
//  Demo9_Autolayout_Code_VFL
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
    //1.创建控件并加入到视图（必须在约束前加入到视图）
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Button1" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"Button2" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button2];
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 setTitle:@"Button3" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button3];
    
    //1.关掉autoresizing翻译
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    button3.translatesAutoresizingMaskIntoConstraints = NO;
    
    //2.创建约束
    NSString * expression = nil;
    
    //NSDictionary * controls = @{@"button1":button1, @"button2":button2};
    NSDictionary * controls = NSDictionaryOfVariableBindings(button1, button2, button3);//返回的是上面创建的字典
    
    expression = @"|-10-[button1]-10-[button2(==button1)]-10-[button3(==button1)]-10-|";
    
    NSArray * horizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:expression//约束
                                            options:NSLayoutFormatAlignAllCenterY
                                            metrics:0
                                              views:controls];//字典
    //3.将约束加入视图中
    [self.view addConstraints:horizontalConstraints];
    
/*----------------------------纵向约束-----------------------------------------------*/
    
    //button1
    expression = @"V:|-50-[button1]";//垂直用“V:”表示
    NSArray * v1 =
    [NSLayoutConstraint constraintsWithVisualFormat:expression
                                            options:0
                                            metrics:0
                                              views:controls];
    [self.view addConstraints:v1];
    
//    //button2
//    expression = @"V:|-50-[button2]";
//    NSArray * v2 =
//    [NSLayoutConstraint constraintsWithVisualFormat:expression
//                                            options:0
//                                            metrics:0
//                                              views:controls];
//    [self.view addConstraints:v2];
//    
//    //button3
//    expression = @"V:|-50-[button3]";
//    NSArray * v3 =
//    [NSLayoutConstraint constraintsWithVisualFormat:expression
//                                            options:0
//                                            metrics:0
//                                              views:controls];
//    [self.view addConstraints:v3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
