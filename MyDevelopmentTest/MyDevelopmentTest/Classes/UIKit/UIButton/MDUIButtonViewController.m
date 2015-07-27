//
//  MDUIButtonViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/17.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIButtonViewController.h"

@interface MDUIButtonViewController ()

@end

@implementation MDUIButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test0];
}

-(void)test0
{
    UIButton *signBtn = [[UIButton alloc] init];
    signBtn.frame = CGRectMake(0, 0, 80, 40);
    [signBtn.layer setMasksToBounds:YES];//设为yes则无阴影效果
    [signBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [signBtn.layer setBorderWidth:1.0]; //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [signBtn.layer setBorderColor:colorref];//边框颜色
    
    [signBtn setTitle:@"还  原" forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    signBtn.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:signBtn];
}

-(void)test1
{
    //简单的btn
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [btn setTitle:@"改变" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)test2
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    [self.view addSubview:btn];
    
    //设置图片
    //    [btn setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];//跟文字冲突
    [btn setImageEdgeInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    btn.showsTouchWhenHighlighted = YES;//点击时高亮
    
    [btn setTintColor:[UIColor redColor]];
    [btn setTitle:@"哈哈" forState:UIControlStateNormal];
    [btn setTitle:@"嘻嘻" forState:UIControlStateHighlighted];
    
    
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(50, 0, 0, 0);//文字距离四边的距离：上左下右
    btn.titleEdgeInsets = UIEdgeInsetsMake(25, 0, -25, 0);//与上面一样
    //    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//文字水平排列：居中、左右、充满
}

-(void)test3
{
    //圆角button
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 175, 200, 100)];
    [logoutButton.layer setCornerRadius:10.0];
    [logoutButton.layer setBorderColor:[UIColor redColor].CGColor];
    [logoutButton.layer setBorderWidth:1.0];
    [logoutButton.layer setMasksToBounds:YES];
    [logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logoutButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:logoutButton];
}

-(void)test4
{
    //阴影
    UIButton *signBtn = [[UIButton alloc] init];
    signBtn.frame = CGRectMake(0, 0, 80, 40);
    [signBtn.layer setShadowColor:[UIColor redColor].CGColor];
    [signBtn.layer setShadowOffset:CGSizeMake(5, 5)];
    [signBtn.layer setShadowOpacity:1];
    [signBtn.layer setShadowRadius:5];
    [signBtn setTitle:@"还  原" forState:UIControlStateNormal];//button title
    [signBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//title color
    signBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signBtn];

}

-(void)test5
{

}

@end
