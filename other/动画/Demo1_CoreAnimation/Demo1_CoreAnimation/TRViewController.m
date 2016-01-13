//
//  TRViewController.m
//  Demo1_CoreAnimation
//
//  Created by Tarena on 13-11-26.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.layer.cornerRadius = 20; //圆角半径
    self.imageView.layer.masksToBounds = YES; //开启蒙板
    
    CATransform3D transform = CATransform3DIdentity;//三维中的趋向深度
    transform.m34 =  1.0/1000 ;//值越大，倾斜角度越大，正负号代表方向
    
    transform = CATransform3DRotate
    (transform, M_PI_4, 0, 1, 0);//参数：你要变换的现有的transform，x坐标，y坐标，z坐标（xyz谁有值则以谁为轴心倾斜，值大小与效果无关，正负号代表方向）
    
    transform = CATransform3DRotate
    (transform, M_PI_4, 1, 0, 0);
    
//    transform = CATransform3DRotate
//    (transform, M_PI_4, 1, 1, 0);//效果不等价于上面两个的组合
    
    self.imageView.layer.transform = transform;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
