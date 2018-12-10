//
//  HFSecondViewController.m
//  text
//
//  Created by hanyfeng on 14-6-19.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFSecondViewController.h"

@interface HFSecondViewController ()

@end

@implementation HFSecondViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)tap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

//IOS6.0或以后该vc支持的旋转方向
//旋转到支持的方向后，vc的内容会自动旋转，最终效果为正视效果（非倒视或侧视）
//必须至少有一个方向跟设备旋转方向对应 否则会崩溃
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
