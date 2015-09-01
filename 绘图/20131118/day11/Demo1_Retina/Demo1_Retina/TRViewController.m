//
//  TRViewController.m
//  Demo1_Retina
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * image = [UIImage imageNamed:@"Welcome_3.0_1.jpg"];
    NSLog(@"%.2f, %.2f", image.size.width, image.size.height);
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
