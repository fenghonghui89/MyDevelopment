//
//  TRView.m
//  my04
//
//  Created by HanyFeng on 13-11-23.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRView.h"

@interface TRView ()
@property(nonatomic,strong)NSMutableArray* points;
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

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    CGPoint point = [self.points[0] cgpoint];
    [path moveToPoint:point];
    for (int i =1; i<self.points.count; i++) {//绘制移动时的轨迹，所以初始化为1
        CGPoint point = [self.points[i] cgpoint];
        [path addLineToPoint:point];
    }
    
    path.lineWidth = self.lineWidth;
    [[UIColor redColor] setStroke];
    [path stroke];
    
    CGContextRestoreGState(context);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.points = [NSMutableArray array];
    
    UITouch* touch = [touches allObjects][0];
    CGPoint point = [touch locationInView:self];
    
    //结构体类型无法放入数组，要转换成对象类型才能放入数组
    TRPoint* trpoint = [[TRPoint alloc] initWithCGPoint:point];
    [self.points addObject:trpoint];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches allObjects][0];
    CGPoint point = [touch locationInView:self];
    TRPoint* trpoint = [[TRPoint alloc] initWithCGPoint:point];
    [self.points addObject:trpoint];
    [self setNeedsDisplay];//重绘
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
