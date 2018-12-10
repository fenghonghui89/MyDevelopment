//
//  HFFirstViewController.m
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFFirstViewController.h"
#import "HFSecondViewController.h"
@interface HFFirstViewController ()

@end

@implementation HFFirstViewController

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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 20)];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setText:@"1 viewController"];
    [label sizeToFit];
    [label setTextColor:[UIColor greenColor]];
    [self.view addSubview:label];
    [label release];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"跳转到2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn release];
}

-(void)presentVC{
    HFSecondViewController *svc = [[HFSecondViewController alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
    [svc release];
}

-(void)dealloc{
    NSLog(@"fvc dealloc");
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
