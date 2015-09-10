//
//  MD_UISlider_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UISlider_ViewController.h"
@interface MD_UISlider_ViewController()
@property(nonatomic,strong)UISlider *slider;
@end
@implementation MD_UISlider_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
}

-(void)customInitUI
{
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 10, viewW-20, 30)];
    [self.view addSubview:slider];
    _slider = slider;
    [self uisliderTest];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - < test > -
-(void)uisliderTest
{
    UIImage* image1 = [UIImage imageNamed:@"playing_volumn_slide_bg.png"];
    [_slider setMinimumTrackImage:image1 forState:UIControlStateNormal];
    
    UIImage* image2 = [UIImage imageNamed:@"playing_volumn_slide_foreground.png"];
    [_slider setMaximumTrackImage:image2 forState:UIControlStateNormal];
    
    UIImage* image3 = [UIImage imageNamed:@"playing_volumn_slide_sound_icon.png"];
    [_slider setThumbImage:image3 forState:UIControlStateNormal];
}

-(void)sliderChange:(UISlider *)slider
{
    NSLog(@"value:%f",slider.value);
}
@end
