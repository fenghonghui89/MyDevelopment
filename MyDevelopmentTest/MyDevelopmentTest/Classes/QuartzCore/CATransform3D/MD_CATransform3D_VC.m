//
//  MD_CATransform3D_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 16/4/17.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_CATransform3D_VC.h"

@interface MD_CATransform3D_VC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MD_CATransform3D_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self test_3d];
}
#pragma mark - < method > -

-(void)test_3d{

  self.imageView.layer.cornerRadius = 20; //圆角半径
  self.imageView.layer.masksToBounds = YES; //开启蒙板
  
  CATransform3D transform = CATransform3DIdentity;//三维中的趋向深度
  transform.m34 =  1.0/1000 ;//值越大，倾斜角度越大，正负号代表方向
  
  transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);//参数：你要变换的现有的transform，x坐标，y坐标，z坐标（xyz谁有值则以谁为轴心倾斜，值大小与效果无关，正负号代表方向）
  
  transform = CATransform3DRotate(transform, M_PI_4, 1, 0, 0);
  
//  transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);//效果不等价于上面两个的组合
  
  self.imageView.layer.transform = transform;
}
@end
