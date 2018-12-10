//
//  TRViewController.m
//  my04
//
//  Created by HanyFeng on 13-11-15.
//  Copyright (c) 2013年 Hany. All rights reserved.
//
#import "TRSecondViewController.h"
#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"A viewDidLoad");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"A viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"A viewDidAppear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"A viewDidDisappeaer");
}

- (IBAction)tap:(id)sender {
    TRSecondViewController* second = [[TRSecondViewController alloc] initWithNibName:@"TRSecondViewController" bundle:nil];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
