//
//  TRView.m
//  my02
//
//  Created by HanyFeng on 13-11-16.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(10, self.bounds.size.height-10)];//对应的view的高度，类似于scrollview
//    [path addLineToPoint:CGPointMake(self.bounds.size.width-10, 10)];
    [path closePath];
   
    path.lineWidth = 10;//线粗
    //path.lineJoinStyle = kCGLineJoinRound;//两线交点样式：直角、圆角、切角
    path.lineCapStyle = kCGLineCapRound;
    
    [[UIColor redColor] setFill];
    [[UIColor blackColor]setStroke];
    
//    [path fill];
    [path stroke];
    CGContextRestoreGState(context);
}

@end
