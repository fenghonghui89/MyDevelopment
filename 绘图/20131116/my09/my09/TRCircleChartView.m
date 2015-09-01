//
//  TRCircleChartView.m
//  my09
//
//  Created by HanyFeng on 13-11-17.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRCircleChartView.h"

@implementation TRCircleChartView

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
    TRData* tempData;
    float origin = 0;//起点
    for (int i = 0; i<self.dataArray.count ; i++) {
        tempData = self.dataArray[i];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
                        radius:120
                    startAngle:M_PI*1.5+M_PI*2*origin
                      endAngle:M_PI*1.5+M_PI*2*(origin+tempData.value)
                     clockwise:YES];
        [path closePath];
        
        [tempData.color setFill];
        
        [path fill];
        
        CGContextRestoreGState(context);
        origin += tempData.value;//下一个扇形的起点=上一个扇形的终点
    }
    
    
}


@end
