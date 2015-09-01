//
//  TRView.m
//  Demo3_DrawPad
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRView.h"
#import "TRPoint.h"

@interface TRView ()

@property (strong, nonatomic) NSMutableArray * points;

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
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    TRPoint * startPoint = self.points[0];
    [path moveToPoint:[startPoint CGPoint]];
    
    for (int i = 1; i < self.points.count; i++) {
        TRPoint * point = self.points[i];
        [path addLineToPoint:[point CGPoint]];
    }
    
    
//    path.lineWidth = 6;
    path.lineWidth = self.lineWidth;

    [[UIColor grayColor] setStroke];
    
    [path stroke];
    
    CGContextRestoreGState(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.points = [NSMutableArray array];
    
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    
    TRPoint * point = [[TRPoint alloc] initWithCGPoint:location];
    [self.points addObject:point];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    
    TRPoint * point = [[TRPoint alloc] initWithCGPoint:location];
    [self.points addObject:point];
    
    [self setNeedsDisplay];
}

@end
