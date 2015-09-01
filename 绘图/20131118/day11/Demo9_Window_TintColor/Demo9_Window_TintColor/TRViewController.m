//
//  TRViewController.m
//  Demo9_Window_TintColor
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRSecondViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.tintColor = [UIColor redColor];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(id)sender {
    TRSecondViewController * second =
    [[TRSecondViewController alloc] initWithNibName:@"TRSecondViewController" bundle:nil];
    
    UINavigationController * navi =
    [[UINavigationController alloc] initWithRootViewController:second];
    
    [self presentViewController:navi animated:YES completion:nil];
    
}

@end
