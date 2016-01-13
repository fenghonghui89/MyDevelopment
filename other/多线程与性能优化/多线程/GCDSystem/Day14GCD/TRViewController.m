//
//  TRViewController.m
//  Day14GCD
//
//  Created by Tarena on 13-12-19.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)clicked:(id)sender
{
    //开启子线程
    //dispatch_async（线程队列，子线程代码块）
    //dispatch_get_global_queue参数：1.线程优先级 2.预留参数（一般没用，直接给0）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 5; i++) {
            NSString *path = @"http://tingge.9ku.com/mp3/184/183203.mp3";
            NSData *mp3Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
            [mp3Data writeToFile:[NSString stringWithFormat:@"/Users/hanyfeng/Desktop/%d.mp3",i] atomically:YES];
            
            //从子线程回到主线程（与开启子线程步骤类似）
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100*i, 100, 100)];
                label.text = [NSString stringWithFormat:@"%d下载完成",i];
                [self.view addSubview:label];
            });
        }
    });
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
