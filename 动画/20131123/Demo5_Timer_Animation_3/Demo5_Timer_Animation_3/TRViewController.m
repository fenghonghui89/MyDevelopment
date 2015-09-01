//
//  TRViewController.m
//  Demo5_Timer_Animation_3
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *aircraft;
@property(weak,nonatomic)NSTimer* timer;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#define FPS 30.0

- (IBAction)tap:(id)sender {
    
    self.timer =
    [NSTimer scheduledTimerWithTimeInterval:1/FPS
                                     target:self
                                   selector:@selector(animate:)
                                   userInfo:nil
                                    repeats:YES ];
}
     
- (void)animate:(id)sender
{
    //当前值 = 上一次的值 + (目标值 - 上一次值) * 渐进因子
    CGPoint center = self.aircraft.center;
    
//    center.y = center.y + (300 - center.y) * 0.1;
    center.y += (300 - center.y) * 0.1;
    
    self.aircraft.center = center;
    
    //设置终止条件
    CGFloat d = 300 - center.y;//差距
    if (fabs(d) < 0.5) {//当间距的绝对值<0.5就停止，直接为目标值
        center.y = 300;
        self.aircraft.center = center;
        [self.timer invalidate];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
