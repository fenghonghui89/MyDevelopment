//
//  TRViewController.m
//  Demo7_Cell
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRMusicsViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//推出第二个界面
- (IBAction)tap:(id)sender {
    TRMusicsViewController * musicsViewController =
    [[TRMusicsViewController alloc] initWithNibName:@"TRMusicsViewController" bundle:nil];
    
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:musicsViewController];
    
    [self presentViewController:navi animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
