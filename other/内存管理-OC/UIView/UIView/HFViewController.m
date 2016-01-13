//
//  HFViewController.m
//  UIView
//
//  Created by hanyfeng on 14-3-27.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//



#import "HFViewController.h"
#import "HFMyFramework.h"
#import "HFSecondViewController.h"

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
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 100, 20)];
    [btnAdd setBackgroundColor:[UIColor grayColor]];
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    [btnAdd release];
    
    UIButton *btnPresent = [[UIButton alloc] initWithFrame:CGRectMake(150, 330, 100, 20)];
    [btnPresent setBackgroundColor:[UIColor grayColor]];
    [btnPresent setTitle:@"跳转" forState:UIControlStateNormal];
    [btnPresent setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnPresent addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPresent];
    [btnPresent release];
    
    UIButton *btnInfo = [[UIButton alloc] initWithFrame:CGRectMake(150, 360, 100, 20)];
    [btnInfo setBackgroundColor:[UIColor grayColor]];
    [btnInfo setTitle:@"信息" forState:UIControlStateNormal];
    [btnInfo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnInfo];
    [btnInfo release];
    
    UIButton *btnDel = [[UIButton alloc] initWithFrame:CGRectMake(150, 390, 100, 20)];
    [btnDel setBackgroundColor:[UIColor grayColor]];
    [btnDel setTitle:@"删除" forState:UIControlStateNormal];
    [btnDel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnDel addTarget:self action:@selector(deleteAddView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDel];
    [btnDel release];
    
}

#pragma mark ---addview---
-(void)addView{
    HFMyFramework *mf = [HFMyFramework shareMyFramework];
    [mf addView];
}

#pragma mark ---present---
-(void)present{
    HFSecondViewController *svc = [[HFSecondViewController alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
    [svc release];
}

#pragma mark ---log---
-(void)info{
    printf("-----------------------------------\n");
    NSLog(@"view:%@",self);
    NSLog(@"view.subviews.count:%d",[[self.view subviews] count]);
    NSLog(@"view.subviews:%@",self.view.subviews);
    
    NSLog(@"window.subviews.count:%d",[[UIApplication sharedApplication] keyWindow].subviews.count);
    NSLog(@"window.subviews:%@",[[UIApplication sharedApplication]keyWindow].subviews);
    printf("-----------------------------------\n");
}

#pragma mark ---delete---
-(void)deleteAddView{
    [[HFMyFramework shareMyFramework] deleteAddView];
}

-(void)dealloc{
    NSLog(@"vc:%@",self);
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
