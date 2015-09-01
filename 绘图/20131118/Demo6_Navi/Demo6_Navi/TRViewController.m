//
//  TRViewController.m
//  Demo6_Navi
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
    
    UINavigationController * navi =[[UINavigationController alloc] initWithRootViewController:second];
    
    //修改navigationBar的背景图
    UIImage * naviImage = [UIImage imageNamed:@"navigation_bar.png"];
    UIImage * resizedNaviImage =[naviImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 2, 10)resizingMode:UIImageResizingModeStretch];
    
    [navi.navigationBar setBackgroundImage:resizedNaviImage forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:navi animated:YES completion:nil];

}

@end
