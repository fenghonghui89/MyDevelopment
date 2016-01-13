//
//  HFViewController.m
//  helloworld
//
//  Created by hanyfeng on 14-5-21.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"

@interface HFViewController ()

@end

@implementation HFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)tap:(id)sender {
    self.label.text = @"哈哈";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//职能：释放内存，包括vc中的一些成员变量和视图的释放
- (void)didReceiveMemoryWarning
{
    self.label = nil;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
