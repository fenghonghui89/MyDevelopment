//
//  TRViewController.m
//  my03
//
//  Created by HanyFeng on 13-11-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	UIRotationGestureRecognizer* rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self.view addGestureRecognizer:rotationGR];
}

-(void)rotate:(UIRotationGestureRecognizer*)rotationGR
{
    NSLog(@"%.2f",rotationGR.rotation);//当次旋转的角度
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
