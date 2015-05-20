//
//  MDNavi1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNavi1ViewController.h"

@interface MDNavi1ViewController ()
@property(nonatomic,strong)UIActivityIndicatorView *aiview;
@end

@implementation MDNavi1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [btn setTitle:@"改变" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(110, 50, 50, 50)];
    [btn1 setTitle:@"改变1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(170, 50, 50, 50)];
    [btn2 setTitle:@"取消1" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 addTarget:self action:@selector(tap3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

#pragma mark - action
#pragma mark title/UIBarButtonItem
-(void)tap
{
    self.title = @"First";//title是VC的属性，只是被navi调用了而已
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancle" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIBarButtonItem* b1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(add:)];
    UIBarButtonItem* b2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[b1,b2];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)add:(id)sender
{
    NSLog(@".........");
}

#pragma mark titleview/prompt
-(void)tap1
{
    //titleview（注意，titleView与tilte的位置是重合的、互斥的）
    UIActivityIndicatorView *aiview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.titleView = aiview;
    self.aiview = aiview;
    [aiview startAnimating];
    
    //prompt属性（使用titleview后如果想显示文字，就用prompt）
    self.navigationItem.prompt = @"数据加载中";
}

-(void)tap2
{
    [self.aiview stopAnimating];
    self.navigationItem.titleView = nil;
    self.navigationItem.prompt = nil;
    self.navigationItem.title = @"主界面";
}

#pragma mark toolbar/FlexibleSpace/FixedSpace
-(void)tap3
{
    //设置Navigation ToolBar
//    self.navigationController.toolbarHidden = NO;
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    //木棍效果，按指定宽度填补空间
    UIBarButtonItem* t1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    t1.width = 20;
    UIBarButtonItem* t2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    t2.width = 20;
    
    //弹簧效果，尽可能填补空间
    UIBarButtonItem* t3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* t4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* t5 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:nil action:nil];
    UIBarButtonItem* t6= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    UIBarButtonItem* t7 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:nil action:nil];
    self.toolbarItems = @[t1,t5,t3,t6,t4,t7,t2];
}

@end
