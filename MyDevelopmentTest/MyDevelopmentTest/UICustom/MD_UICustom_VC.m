
//
//  MD_UICustom_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UICustom_VC.h"
#import "MDCircularSlider.h"
@interface MD_UICustom_VC()
@end
@implementation MD_UICustom_VC
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customInitUI];
}


-(void)customInitUI
{
    MDCircularSlider *cs = [[MDCircularSlider alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [cs addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:cs];
}

-(void)newValue:(MDCircularSlider*)slider
{
    NSLog(@"Slider Value %d",slider.angle);
}
@end
