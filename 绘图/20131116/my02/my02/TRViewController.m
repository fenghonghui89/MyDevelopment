//
//  TRViewController.m
//  my02
//
//  Created by HanyFeng on 13-11-16.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRView.h"
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TRView *view = [[TRView alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
