//
//  TRViewController.m
//  Demo8_Redraw
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;

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

//viewDidLayoutSubviews
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.view1.frame = self.view.bounds;
}

@end
