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
    printf("\n");

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 130, 100, 20)];//1
    NSLog(@"btn1:%p",btn);
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"返回到1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];//2
    [btn release];//1
    
    UIImageView *myView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 200,50)];//1
    NSLog(@"imageview:%p",myView);
    [myView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:myView];//2
    [myView release];//1
    
    //推荐写法
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 20)];//1
    NSLog(@"label:%p",label);
    [label setBackgroundColor:[UIColor blueColor]];
    [label setText:@"未回调"];
    [label setTextColor:[UIColor greenColor]];
    [myView addSubview:label];//2
    self.label = label;//3
    [label release];//2
    
    //下面这种也可以，引用计数也一样，但不推荐
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 20)];//1
//    NSLog(@"label:%p",label);
//    [label setBackgroundColor:[UIColor blueColor]];
//    [label setText:@"未回调"];
//    [label setTextColor:[UIColor greenColor]];
//    self.label = label;//2
//    [myView addSubview:label];//3
//    [label release];//2
    
}

-(void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"---svc dealloc");//2
    [_label release];//1
    _label = nil;
    [super dealloc];//0
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
