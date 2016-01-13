//
//  TRSecondViewController.m
//  my04
//
//  Created by HanyFeng on 13-11-15.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRSecondViewController.h"

@interface TRSecondViewController ()

@end

@implementation TRSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"B viewDidLoad");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"B viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"B viewDidAppear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"B viewDidDisappeaer");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
