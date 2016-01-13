//
//  HFThirdViewController.m
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFThirdViewController.h"

@interface HFThirdViewController ()

@end

@implementation HFThirdViewController

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
    
    printf("\n");
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 20)];
    NSLog(@"label:%p",label);
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setText:@"3-1 viewController"];
    [label sizeToFit];
    [label setTextColor:[UIColor greenColor]];
    [self.view addSubview:label];
    [label release];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    NSLog(@"btn:%p",btn);
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"返回到2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn release];
}

-(void)dismissVC{
    [self.delegate thirdViewController:self AndText:@"已回调"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"tvc dealloc");
    self.delegate = nil;//delegate不用release，置nil就可以
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
