//
//  HFSecondViewController.m
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFSecondViewController.h"

@interface HFSecondViewController ()
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)HFThirdViewController *tvc;
@property(nonatomic,retain)HFView *hfv;
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 20)];
    NSLog(@"label:%p",label);
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setText:@"2 viewController"];
    [label sizeToFit];
    [label setTextColor:[UIColor greenColor]];
    [self.view addSubview:label];
    [label release];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    NSLog(@"btn:%p",btn);
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"跳转到3" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn release];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 130, 100, 20)];
    NSLog(@"btn1:%p",btn1);
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 setTitle:@"返回到1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 release];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 160, 100, 20)];
    NSLog(@"label1:%p",label1);
    [label1 setBackgroundColor:[UIColor grayColor]];
    [label1 setText:@"未回调"];
    [label1 setTextColor:[UIColor greenColor]];
    [self.view addSubview:label1];
    [label1 release];
    self.label = label1;
}

-(void)presentVC{
//    HFThirdViewController *tvc = [[HFThirdViewController alloc] init];
//    tvc.delegate = self;
//    [self presentViewController:tvc animated:YES completion:nil];
//    self.tvc = tvc;
//    [tvc release];
    
    HFView *hfv = [[HFView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    hfv.delegate = self;
    [hfv setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:hfv];
    self.hfv = hfv;
    [hfv release];
}

-(void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)thirdViewController:(HFThirdViewController *)thirdViewController AndText:(NSString *)text{
    [self.label setText:text];
}

-(void)view:(HFView *)view AndText:(NSString *)text{
    [self.label setText:text];
}

-(void)dealloc{
    printf("\n");
    NSLog(@"svc dealloc");
    [_label release];
    _label = nil;
    
    _tvc.delegate = nil;
    [_tvc release];
    _tvc = nil;
    
    _hfv.delegate = nil;
    [_hfv release];
    _hfv = nil;
    
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
