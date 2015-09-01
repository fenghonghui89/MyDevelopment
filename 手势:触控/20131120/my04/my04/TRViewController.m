//
//  TRViewController.m
//  my04
//
//  Created by HanyFeng on 13-11-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //记得要关闭 Use Autolayout
    
    //错误：不会同时运行
//    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_4);//旋转角度
//    self.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);//缩放
    
    //正确：通过中间变量修改
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_4);

    CGAffineTransform transform = self.imageView.transform;
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    self.imageView.transform = transform;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
