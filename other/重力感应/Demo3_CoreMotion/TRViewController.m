//
//  TRViewController.m
//  Demo3_CoreMotion
//
//  Created by apple on 13-8-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TRViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface TRViewController ()

@property (nonatomic, strong) CMMotionManager * motionManager;
@property (weak, nonatomic) IBOutlet UIView *myBall;
@property(nonatomic,assign)float oldX;
@property(nonatomic,assign)float oldY;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建一个重力感应的对象
    self.motionManager = [[CMMotionManager alloc] init];
    
#define INTERVAL 0.03
    //设置更新时间
    self.motionManager.accelerometerUpdateInterval = INTERVAL;
   
    //开始检测
    [self.motionManager startAccelerometerUpdates];
    
    [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)update
{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
