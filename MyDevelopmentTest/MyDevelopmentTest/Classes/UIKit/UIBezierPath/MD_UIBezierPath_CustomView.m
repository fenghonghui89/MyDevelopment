//
//  MD_UIBezierPath_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/7.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIBezierPath_CustomView.h"

@implementation MD_UIBezierPath_CustomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    /*注：
     注意代码顺序所造成的图层覆盖
     */
    
    [self custom4drawRect:rect];
}

#pragma mark - < ation > -

#pragma mark 画线段
-(void)customdrawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 200)];
    
    path.lineWidth = 10;
    
    [[UIColor greenColor] setStroke];
    
    [path stroke];
}

#pragma mark 画三角形
-(void)custom1drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(200, 100)];
//    [path addLineToPoint:CGPointMake(100, 100)];
    [path closePath];
    
    [[UIColor redColor] setFill];
    [[UIColor greenColor] setStroke];
    
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;//两线交点类型
    
    [path fill];
    [path stroke];
}

#pragma mark 画扇形
-(void)custom2drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);

    //起点不在圆心
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addArcWithCenter:CGPointMake(100, 100)//圆心
                    radius:100//半径
                startAngle:0//起始角度对应的sin
                  endAngle:M_PI_2//终点角度对应的sin
                 clockwise:YES];//YES：顺时针画 NO：逆时针画
    [path closePath];
    
    [[UIColor redColor] setFill];
    [path fill];
    
    //起点在圆心
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(100, 100)];
    [path1 addArcWithCenter:CGPointMake(100, 100)//圆心
                    radius:100//半径
                startAngle:0//起始角度对应的sin
                  endAngle:M_PI_2//终点角度对应的sin
                 clockwise:YES];//YES：顺时针画 NO：逆时针画
    [path1 closePath];
    
    [[UIColor greenColor] setFill];
    [path1 fill];
    
}

#pragma mark 练习：画带圆角的正方形
-(void)custom3drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
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
    
    path.lineWidth = 4;
    [[UIColor redColor] setFill];
    [[UIColor greenColor] setStroke];
    [path stroke];
    [path fill];
}

#pragma mark 画曲线
-(void)custom4drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 10)];//起始点p1
    [path addCurveToPoint:CGPointMake(10, 110)//结束点p2
            controlPoint1:CGPointMake(10, 10)//控制点cp1-起始点的趋向
            controlPoint2:CGPointMake(50, 110)];//控制点cp2-结束点从哪来
    
    [path addCurveToPoint:CGPointMake(50, 210)
            controlPoint1:CGPointMake(50, 110)
            controlPoint2:CGPointMake(10, 210)];
    
    [[UIColor grayColor] setStroke];
    path.lineWidth = 2;
    [path stroke];

    
}

#pragma mark 练习：画饼图
-(void)custom5drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    NSArray *dataArray = @[[NSNumber numberWithFloat:0.2],[NSNumber numberWithFloat:0.2],[NSNumber numberWithFloat:0.2]];
    float origin = 0;//起点
    for (int i = 0; i<dataArray.count ; i++) {
        NSNumber *valueObj = dataArray[i];
        CGFloat value = [valueObj floatValue];
        
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
                        radius:120
                    startAngle:M_PI*1.5+M_PI*2*origin
                      endAngle:M_PI*1.5+M_PI*2*(origin+value)
                     clockwise:YES];
        [path closePath];
        
        UIColor *color= [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1];
        [color setFill];
        
        [path fill];
        
        origin += value;//下一个扇形的起点=上一个扇形的终点
    }
}
@end
