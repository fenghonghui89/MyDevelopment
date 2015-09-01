//
//  TRViewController.m
//  Demo5_Layout_Code
//
//  Created by Tarena on 13-11-21.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"%.2f, %.2f", self.view.bounds.size.width, self.view.bounds.size.height);
    //     对子view的纯代码布局
    
    CGRect frame = self.label.frame;
    frame.origin.x =
    self.view.bounds.size.width - 20 - frame.size.width;
    frame.origin.y =
    self.view.bounds.size.height - 20 - frame.size.height;
    self.label.frame = frame;
}

@end
