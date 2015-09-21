//
//  TRViewController.m
//  Day11Homework
//
//  Created by HanyFeng on 13-12-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImage* image = Nil;
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
