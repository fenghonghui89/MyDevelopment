//
//  TRViewController.m
//  my05
//
//  Created by HanyFeng on 13-11-21.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //情况1：放在viewDidLoad——转为横屏后不会布局到适合位置
//    CGRect frame = self.label.frame;
//    frame.origin.x = self.view.bounds.size.width - 20 - frame.size.width;
//    frame.origin.y = self.view.bounds.size.height - 20 -frame.size.height;
//    self.label.frame = frame;
//    
//    NSLog(@"view:%.2f,%.2f",self.view.bounds.size.width,self.view.bounds.size.height);
//    NSLog(@"label:%.2f,%.2f",self.label.frame.origin.x,self.label.frame.origin.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//情况2：放在viewDidLayoutSubviews——会根据代码布局到合适的位置
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //对子view的纯代码布局（无论竖屏还是横屏，label位置都不变）（取出来改一改再放回去）
    CGRect frame = self.label.frame;
    frame.origin.x = self.view.bounds.size.width - 20 - frame.size.width;
    frame.origin.y = self.view.bounds.size.height - 20 -frame.size.height;
    self.label.frame = frame;
    
    NSLog(@"view:%.2f,%.2f",self.view.bounds.size.width,self.view.bounds.size.height);
    NSLog(@"label:%.2f,%.2f",self.label.frame.origin.x,self.label.frame.origin.y);
}

@end
