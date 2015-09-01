//
//  TRViewController.m
//  Demo5_Timer_Animation_3
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //结束位置
    CGRect endFrame = self.label.frame;
    
    //开始位置
    CGRect startFrame = endFrame;
    startFrame.origin.x = 0 - startFrame.size.width;
    
    //  设置动画开始的状态
    self.label.frame = startFrame;
    self.label.alpha = 0;
    
    //简化版代码
    [UIView animateWithDuration:1.0 animations:^{
        //  设置动画结束的状态，这部分代码会被穿越，
        //  在接下来的1秒钟时间内慢慢分次执行
        self.label.frame = endFrame;
        self.label.alpha = 1;
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
