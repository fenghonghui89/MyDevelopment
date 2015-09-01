//
//  TRViewController.m
//  Demo7_Layout_Code_OS7
//
//  Created by Tarena on 13-11-21.
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
    
    UITabBarController* tabbarController = [UITabBarController new];
    tabbarController.viewControllers = @[navi];

    [self presentViewController:tabbarController animated:YES completion:nil];
    
}
@end
