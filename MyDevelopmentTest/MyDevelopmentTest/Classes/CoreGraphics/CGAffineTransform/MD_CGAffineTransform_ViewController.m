//
//  MD_CGAffineTransform_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_CGAffineTransform_ViewController.h"
@interface MD_CGAffineTransform_ViewController()
@end
@implementation MD_CGAffineTransform_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self cgAffineTransformTest];
}

#pragma mark - < test > -
-(void)cgAffineTransformTest
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"]];
    [iv setFrame:CGRectMake(60, 27, 212, 203)];
    [self.view addSubview:iv];
    
    /*
     注意：
     1.记得要关闭 Use Autolayout
     2.通过中间变量修改
     */
    CGAffineTransform transform = iv.transform;
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    transform = CGAffineTransformRotate(transform, M_PI_4);
    iv.transform = transform;
}
@end
