//
//  MD_Touch_CostomView1.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//练习：点击拖动画出矩形

#import "MD_Touch_CustomView1.h"
@interface MD_Touch_CustomView1()
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)CGRect rect;
@end
@implementation MD_Touch_CustomView1
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.rect];
    
    [[UIColor redColor] setFill];
    [[UIColor blueColor] setStroke];
    [path fill];
    [path stroke];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches allObjects][0];
    self.startPoint = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches allObjects][0];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat minX = MIN(_startPoint.x, currentPoint.x);
    CGFloat minY = MIN(_startPoint.y, currentPoint.y);
    CGFloat maxX = MAX(_startPoint.x, currentPoint.x);
    CGFloat maxY = MAX(_startPoint.y, currentPoint.y);
    
    self.rect = CGRectMake(minX, minY, maxX-minX, maxY-minY);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.rect = CGRectZero;
    [self setNeedsDisplay];
}
@end
