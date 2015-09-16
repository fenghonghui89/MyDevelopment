//
//  MD_Touch_CustomView2.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//练习：画多条线
/*
 画多条线的重点是提升path的生命周期，防止画完一根后中断
 注意数组不能插入nil对象，但数组为nil时可以读取，但创建数组后如果未有元素不能读取，否则会崩
 */

#import "MD_Touch_CustomView2.h"
#import "MD_Touch_Point.h"

@interface MD_Touch_CustomView2()
@property(nonatomic,strong)UIBezierPath *path;
@property(nonatomic,strong)NSMutableArray *points;
@end
@implementation MD_Touch_CustomView2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.path = [UIBezierPath bezierPath];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGPoint startPoint = [self.points[0] cgpoint];
    [_path moveToPoint:startPoint];

    for (int i = 1; i<self.points.count; i++) {
        CGPoint movePoint = [self.points[i] cgpoint];
        [_path addLineToPoint:movePoint];
    }
    
    UIColor *color = [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1  blue:arc4random()%10*0.1  alpha:1];
    [color setStroke];
    [_path stroke];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches allObjects][0];
    CGPoint startPoint = [touch locationInView:self];
    MD_Touch_Point *point = [[MD_Touch_Point alloc] initWithPoint:startPoint];
    
    self.points = [NSMutableArray array];//不能在initWithFrame初始化，否则会因为nil对象造成崩溃
    [self.points addObject:point];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches allObjects][0];
    CGPoint currentPoint = [touch locationInView:self];
    MD_Touch_Point *point = [[MD_Touch_Point alloc] initWithPoint:currentPoint];
    
    [self.points addObject:point];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
@end
