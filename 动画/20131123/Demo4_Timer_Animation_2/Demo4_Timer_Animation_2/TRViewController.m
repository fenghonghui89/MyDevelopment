//
//  TRViewController.m
//  Demo4_Timer_Animation_2
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *aircraft;
@property (nonatomic) int times;

@property (weak, nonatomic) NSTimer * timer;


@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define FPS         30.0
#define DURATION    2

- (IBAction)tap:(id)sender
{
    self.timer =
    [NSTimer scheduledTimerWithTimeInterval:1 / FPS
                                     target:self
                                   selector:@selector(animate:)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)animate:(id)sender
{
    self.times ++;
    
    //开始值 + 当前的帧数 * (结束值 - 开始值) / (帧频 * 动画时长)
    CGPoint center = self.aircraft.center;
    center.y = 500 + self.times * (300 - 500) / (FPS * DURATION);
    self.aircraft.center = center;
    
    if (self.times > FPS * DURATION) {
        [self.timer invalidate];
    }
    
}

@end
