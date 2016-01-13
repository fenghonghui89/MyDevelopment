//
//  HFViewController.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"
#import "HFPPAppPlatformKit.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    [btn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [btn setTitle:@"PP中心" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn release];
    
}

-(void)showCenter{
    [[HFPPAppPlatformKit shareInstance] showCenter];
}

-(void)dealloc{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
