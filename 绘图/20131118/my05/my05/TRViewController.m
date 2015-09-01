//
//  TRViewController.m
//  my05
//
//  Created by HanyFeng on 13-11-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *button_disabled;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //用代码美化button（4种状态-正常、Highlighted(点击后未离开)）
    [self.button setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black.png"] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"ToolViewInputVoice.png"] forState:UIControlStateHighlighted];
    
    //button-disabled状态(文字变灰)
    self.button_disabled.enabled = NO;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
