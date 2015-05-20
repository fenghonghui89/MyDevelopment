//
//  MDUILabelViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/27.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUILabelViewController.h"

@interface MDUILabelViewController ()

@end

@implementation MDUILabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customInitUI];
}

-(void)customInitUI
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    
    //颜色
    //NSMakeRange(0,5) 起始位置，长度，空格算1
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
    
    //字号
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] range:NSMakeRange(6, 12)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:15.0] range:NSMakeRange(19, 6)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 20)];
    [label setAttributedText:str];
    [self.view addSubview:label];
}

@end
