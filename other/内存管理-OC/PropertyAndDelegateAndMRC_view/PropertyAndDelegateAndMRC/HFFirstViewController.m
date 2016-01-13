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
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 setTitle:@"跳转到2" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 release];
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
