//
//  TRView.m
//  View_DrawCurve(1122)
//
//  Created by apple on 13-11-22.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRView.h"
#import "TRPoint.h"
#import "TRDrawLine.h"

@interface TRView ()

@property(nonatomic,strong)TRDrawLine* lineDrawed;

@property(nonatomic,strong)NSMutableArray* lineCurveSaved;

@property(nonatomic,strong)UIBezierPath* linePath;

@end

@implementation TRView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineCurveSaved=[NSMutableArray array];
        self.lineDrawed=[[TRDrawLine alloc]init];
        self.linePath=[[UIBezierPath alloc]init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.lineCurveSaved=[NSMutableArray array];
        self.lineDrawed=[[TRDrawLine alloc]init];
        self.linePath=[[UIBezierPath alloc]init];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    TRPoint* point=self.lineDrawed.curvePoints[0];
    [self.linePath moveToPoint:point.pointSaved];
    for (int i=1; i<self.lineDrawed.curvePoints.count; i++) {
        point=self.lineDrawed.curvePoints[i];
        [self.linePath addLineToPoint:point.pointSaved];
    }
    [[UIColor blackColor]setStroke];
    self.linePath.lineJoinStyle=kCGLineJoinRound;
    [self.linePath stroke];
    [self.lineCurveSaved addObject:self.lineDrawed];
    CGContextRestoreGState(context);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.lineDrawed=[[TRDrawLine alloc]init];
    UITouch* touch=[touches allObjects][0];
    TRPoint* point=[[TRPoint alloc]init];
    point.pointSaved=[touch locationInView:self];
    self.lineDrawed.curvePoints=[NSMutableArray arrayWithObject:point];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches allObjects][0];
    TRPoint* point=[[TRPoint alloc]init];
    point.pointSaved=[touch locationInView:self];
    [self.lineDrawed.curvePoints addObject:point];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

@end
