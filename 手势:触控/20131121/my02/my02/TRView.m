  //
//  TRView.m
//  my02
//
//  Created by HanyFeng on 13-11-21.
//  Copyright (c) 2013年 Hany. All rights reserved.
//不用连任何线

#import "TRView.h"

@implementation TRView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"1");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath* path =
    [UIBezierPath bezierPathWithRect:self.rect];//矩形的轨迹由下面的三个方法决定
    
    [[UIColor grayColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    
    [path stroke];
    [path fill];
    
    CGContextRestoreGState(context);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"2");
    UITouch* touch = [touches allObjects][0];
    self.startPoint = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"3");
    UITouch* touch = [touches allObjects][0];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint startPoint = self.startPoint;
    
    CGFloat minX = MIN(startPoint.x, currentPoint.x);
    CGFloat minY = MIN(startPoint.y, currentPoint.y);
    CGFloat maxX = MAX(startPoint.x, currentPoint.x);
    CGFloat maxY = MAX(startPoint.y, currentPoint.y);
    
    self.rect = CGRectMake(minX, minY, maxX-minX,maxY-minY);
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"4");
    self.rect = CGRectZero;
    [self setNeedsDisplay];
}

@end
