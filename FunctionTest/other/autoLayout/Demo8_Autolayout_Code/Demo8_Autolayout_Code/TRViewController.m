//
//  TRViewController.m
//  Demo8_Autolayout_Code
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
    
//1.创建并加入到当前view
    UILabel * label = [[UILabel alloc] init];
    label.text = @"Autolayout";
    [self.view addSubview:label];//必须写在约束之前
    
//2.关闭：把Autoresizing翻译成Autolayout（每个代码生成的控件都有Autoresizing，addSubview时系统会自动翻译成Autolayout）
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;

//3.用代码按照万能公式创建约束对象
    
    //万能公式
    // 公式：   view1.attr1 = view2.attr2 * multiplier + constant
    // 对应参数：1---- 2---- 3 4---- 5----   6---------   7-------
    
    // label.top = self.view.top * 1 + 10
    id topMargin =
    [NSLayoutConstraint constraintWithItem:label
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:10];
    
    // label.right = self.view.right * 1 - 10;
    id rightMargin =
    [NSLayoutConstraint constraintWithItem:label
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:(-10)];
    
//4.加入约束到当前view
    [self.view addConstraints:@[topMargin, rightMargin]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
