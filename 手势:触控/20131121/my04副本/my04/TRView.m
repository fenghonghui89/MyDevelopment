//
//  TRView.m
//  my04
//
//  Created by HanyFeng on 13-11-23.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRView.h"

@interface TRView ()

@end

@implementation TRView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
    NSLog(@"draw");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    CGPoint point = [self.points[0] cgpoint];
    [path moveToPoint:point];
    for (int i =1; i<self.points.count; i++) {
        CGPoint point = [self.points[i] cgpoint];
        [path addLineToPoint:point];
        
    }
    path.lineWidth = 6;
    [[UIColor redColor] setStroke];
    [path stroke];
    
    CGContextRestoreGState(context);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"go");
    
    self.points = [NSMutableArray array];
    UITouch* touch = [touches allObjects][0];
    CGPoint point = [touch locationInView:self];
    
    //结构体类型无法放入数组，要转换成对象类型才能放入数组
    TRPoint* trpoint = [[TRPoint alloc] initWithCGPoint:point];
    [self.points addObject:trpoint];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"move");
    
    UITouch* touch = [touches allObjects][0];
    CGPoint point = [touch locationInView:self];
    
    TRPoint* trpoint = [[TRPoint alloc] initWithCGPoint:point];
    [self.points addObject:trpoint];
    [self setNeedsDisplay];//重绘
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"end");
    
    [self.drawLines addObject:self.points];
    

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
