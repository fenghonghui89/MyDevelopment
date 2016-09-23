//
//  MD_UIBezierPath_CustomView1.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//示例：根据进度条的值画圆弧

#import "MD_UIBezierPath_CustomView1.h"
#import "MDRootDefine.h"
@interface MD_UIBezierPath_CustomView1()
@property(nonatomic,assign)CGFloat value;
@end
@implementation MD_UIBezierPath_CustomView1
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInitUI];
    }
    return self;
}

-(void)customInitUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UISlider *slider = [[UISlider alloc] init];
    [slider setFrame:CGRectMake(10, 10, screenW - 20, 10)];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [slider setValue:0];
    [self addSubview:slider];
}

-(void)sliderValueChange:(UISlider *)slider
{
    _value = slider.value;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];//不能提升为属性
    
    [path moveToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
                    radius:20
                startAngle:M_PI*1.5
                  endAngle:M_PI*1.5 + M_PI*2 *self.value
                 clockwise:YES];
    
    path.lineWidth = 2;
    path.lineCapStyle = kCGLineCapRound;//线条拐角
    [[UIColor redColor] setStroke];
    [path stroke];
}
@end
