//
//  TRViewController.m
//  Demo6_UIView_Animation
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *aircraft;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//viewDidAppear
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect endFrame = self.label.frame;
    
    CGRect startFrame = endFrame;
    startFrame.origin.x = 0 - startFrame.size.width;
    
    //  设置动画开始的状态
    self.label.frame = startFrame;
    self.label.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        //  设置动画结束的状态，这部分代码会被穿越，
        //  在接下来的1秒钟时间内慢慢分次执行
        self.label.frame = endFrame;
        self.label.alpha = 1;
    }];
    
    //  飞机入场动画
    endFrame = self.aircraft.frame;
    startFrame = endFrame;
    startFrame.origin.y = self.view.bounds.size.height;
    
    self.aircraft.frame = startFrame;
    [UIView animateWithDuration:1.0 animations:^{
        self.aircraft.frame = endFrame;
    }];
    
}

//start
- (IBAction)start:(id)sender {
    
    CGPoint center = self.aircraft.center;
    center.y -= 200;
    
    CGAffineTransform transform;
    transform = CGAffineTransformMakeScale(0.5, 0.5);
    transform = CGAffineTransformRotate(transform, M_PI);
    
    //完整版代码
    [UIView animateWithDuration:1.0
                          delay:0 //延迟多久在执行动画
                        options: //效果选项(补间)
     UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse
                     animations:
     ^{
         self.aircraft.center = center;
         self.aircraft.transform = transform;
     }
                     completion:nil];
    
}

//stop
- (IBAction)stop:(id)sender {
    
    CGRect endFrame = self.aircraft.frame;
    endFrame.origin.y = 0 - endFrame.size.height;
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:
     UIViewAnimationOptionCurveEaseIn |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:
     ^{
         self.aircraft.frame = endFrame;
     }
                     completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
