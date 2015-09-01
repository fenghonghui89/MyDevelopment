//
//  TRViewController.m
//  Demo2_Timer
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (nonatomic) int count;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5//每次循环的间隔
                                     target:self
                                   selector:@selector(time:)
                                   userInfo:nil
                                    repeats:YES];
    self.count = 0;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) time:(id)sender
{
    NSLog(@"...");
    
    switch (self.count) {
        case 0:
            self.title = @"连接中";
            break;
        case 1:
            self.title = @"连接中.";
            break;
        case 2:
            self.title = @"连接中..";
            break;
        case 3:
            self.title = @"连接中...";
            break;
            
        default:
            break;
    }
    
    self.count ++;
    self.count %= 4;//等效于下面
//    if (self.count == 4) {
//        self.count = 0;
//    }
    
    
    
    NSLog(@"%d", self.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
