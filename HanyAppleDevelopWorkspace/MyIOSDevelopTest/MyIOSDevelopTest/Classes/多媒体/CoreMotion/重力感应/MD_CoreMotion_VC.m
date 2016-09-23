//
//  MD_CoreMotion_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 16/4/17.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_CoreMotion_VC.h"
@import CoreMotion;

@interface MD_CoreMotion_VC ()
@property (nonatomic, strong) CMMotionManager * motionManager;
@property (weak, nonatomic) IBOutlet UIView *myBall;
@property(nonatomic,assign)float oldX;
@property(nonatomic,assign)float oldY;
@end

@implementation MD_CoreMotion_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
 
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self customInit];
  
}
#pragma mark - < method > -
-(void)customInit{
  
  //创建一个重力感应的对象
  self.motionManager = [[CMMotionManager alloc] init];
  
  //设置更新时间
  self.motionManager.accelerometerUpdateInterval = 0.03;
  
  //开始检测
  [self.motionManager startAccelerometerUpdates];
  
  [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(update) userInfo:nil repeats:YES];

}

- (void)update{
  
  CMAcceleration accleration = self.motionManager.accelerometerData.acceleration;
  NSLog(@"x=%f y=%f z=%f",accleration.x,accleration.y,accleration.z);
  
  float x = self.oldX + accleration.x;
  float y = self.oldY + accleration.y;
  
  self.myBall.center = CGPointMake(self.myBall.center.x+x,self.myBall.center.y-y);
  
  self.oldX = x;
  self.oldY = y;
  
  //触碰到屏幕边缘 球停止并反弹
  if (self.myBall.frame.origin.x <= 0) {
    self.myBall.frame = CGRectMake(0, self.myBall.frame.origin.y, self.myBall.frame.size.width, self.myBall.frame.size.height);
    self.oldX = -self.oldX/2;
  }
}
@end
