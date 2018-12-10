//
//  HFViewController.m
//  ViewWithTag
//
//  Created by hanyfeng on 14-4-11.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"

@interface HFViewController ()
@property(nonatomic,assign)int count;
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
    
    self.count = 1001;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 50, 20)];
    [addButton setTintColor:[UIColor redColor]];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor grayColor]];
    [addButton addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton release];
    
    UIButton *delButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 190, 50, 20)];
    [delButton setTintColor:[UIColor redColor]];
    [delButton setTitle:@"删除" forState:UIControlStateNormal];
    [delButton setBackgroundColor:[UIColor grayColor]];
    [delButton addTarget:self action:@selector(delViews) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delButton];
    [delButton release];
    
}

-(void)addView{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(arc4random()%301, arc4random()%549, 20, 20)];
    NSLog(@"add btn:%p",btn);
    [btn setBackgroundColor:[UIColor colorWithRed:arc4random()%11*0.1 green:arc4random()%11*0.1 blue:arc4random()%11*0.1 alpha:1]];
    [btn addTarget:self action:@selector(delView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:self.count];
    [self.view addSubview:btn];
    [btn release];
    
    self.count++;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    NSLog(@"add label:%p",label);
    [label setText:@"hh"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor redColor]];
    [btn addSubview:label];
    [label release];
}

//点击button删除button
-(void)delView:(UIView*)sender{
    [sender removeFromSuperview];
    NSLog(@"del:%p",sender);
}

//删除按钮触发方法
-(void)delViews{
    
    if (self.count == 1001) {
        NSLog(@"没有了");
        return;
    }
    
    //从指定view里面获取指定tag对应的view
    UIView *view = [self.view viewWithTag:self.count-1];
    
    //防止取得的view已经被上面的方法删除
    if (view == nil) {
        self.count--;
        [self delViews];
        return;
    }
    
    [view removeFromSuperview];
    
    self.count--;
}

-(void)dealloc{
    NSLog(@"hfvc dealloc");
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
