//
//  TRView.m
//  Demo2_Touch_Draw
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRView.h"


@interface TRView ()

@property (nonatomic) CGRect rect;
@property (nonatomic) CGPoint startPoint;

@end

@implementation TRView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath * path =
    [UIBezierPath bezierPathWithRect:self.rect];
    
    [[UIColor grayColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    
    [path stroke];
    [path fill];
    
    CGContextRestoreGState(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches allObjects][0];
    self.startPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches allObjects][0];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint startPoint = self.startPoint;
    
    CGFloat minX = MIN(startPoint.x, currentPoint.x);
    CGFloat minY = MIN(startPoint.y, currentPoint.y);
    CGFloat maxX = MAX(startPoint.x, currentPoint.x);
    CGFloat maxY = MAX(startPoint.y, currentPoint.y);
    
    self.rect =
    CGRectMake(minX, minY, maxX - minX, maxY - minY);
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.rect = CGRectZero;
    [self setNeedsDisplay];
}

@end
