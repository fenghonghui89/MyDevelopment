//
//  TRViewController.m
//  my06
//
//  Created by HanyFeng on 13-11-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRSecondViewController.h"
@interface TRViewController ()


@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

//推出第二个界面
- (IBAction)tap:(id)sender {
    TRSecondViewController* sencond = [TRSecondViewController new];
    [self presentViewController:sencond animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
