//
//  MD_UIViewController_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIViewController_VC.h"
@interface MD_UIViewController_VC()
@end
@implementation MD_UIViewController_VC
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;//相当于不渗透
}

-(void)viewDidLayoutSubviews
{
    //旋屏后的ui位置适配可以在这里设置
}
@end
