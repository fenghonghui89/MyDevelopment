//
//  TRView.m
//  my04
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
    
    [path moveToPoint:CGPointMake(10, 20)];
    
    [path addArcWithCenter:CGPointMake(20, 20)
                    radius:10
                startAngle:M_PI
                  endAngle:1.5*M_PI
                 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(self.bounds.size.width-20, 10)];
    
    [path addArcWithCenter:CGPointMake(self.bounds.size.width-20, 20)
                    radius:10
                startAngle:1.5*M_PI
                  endAngle:0
                 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(self.bounds.size.width-10, self.bounds.size.height-20)];
    
    [path addArcWithCenter:CGPointMake(self.bounds.size.width-20, self.bounds.size.height-20)
                    radius:10
                startAngle:0
                  endAngle:M_PI_2
                 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(20,self.bounds.size.height-10)];
    
    [path addArcWithCenter:CGPointMake(20, self.bounds.size.height-20)
                    radius:10
                startAngle:M_PI_2
                  endAngle:M_PI
                 clockwise:YES];
    
    [path closePath];
    [[UIColor redColor] setFill];
    [[UIColor greenColor]setStroke];
    path.lineWidth=4;
    [path stroke];
    [path fill];
    
    CGContextRestoreGState(context);
}


@end
