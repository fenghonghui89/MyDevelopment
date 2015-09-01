//
//  TRLoadingView.m
//  my05
//
//  Created by HanyFeng on 13-11-16.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRLoadingView.h"

@implementation TRLoadingView

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
 
 CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
 CGFloat radius = 20;
 CGFloat lineWidth = 5;
 
 
 [path addArcWithCenter:center
 radius:radius
 startAngle:M_PI*1.5
 endAngle:M_PI*1.5 + M_PI*2 *self.value
 clockwise:YES];
    NSLog(@"%.2f",self.value);
 path.lineWidth = lineWidth;
 path.lineCapStyle =kCGLineCapRound;
 [[UIColor blueColor] setStroke];
 
 [path stroke];
 CGContextRestoreGState(context);

}


-(void)setValue:(float)value
{
    _value = value;
    [self setNeedsDisplay];//重绘-再次调用drawRect方法
}
@end
