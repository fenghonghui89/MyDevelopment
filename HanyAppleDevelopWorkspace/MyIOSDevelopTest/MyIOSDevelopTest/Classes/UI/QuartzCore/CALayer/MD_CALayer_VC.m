//
//  MD_CALayer_VC.m
//  MyIOSDevelopTest
//
//  Created by hanyfeng on 2018/1/9.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "MD_CALayer_VC.h"

@interface MD_CALayer_VC ()

@end

@implementation MD_CALayer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}


#pragma mark - < test >
//个别圆角
-(void)test1{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 25, 100)
                                                   byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(25, 100)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.lineWidth = 1.f;
//    maskLayer.strokeColor = [UIColor blueColor].CGColor;
//    maskLayer.fillColor = [UIColor greenColor].CGColor;
//    maskLayer.frame = CGRectMake(0, 0, 25, 100);
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
}

//二维码扫描-使响应区域透明
-(void)test2{
    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    CGMutablePathRef path = CGPathCreateMutable();
//
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat w = 0;
//    CGFloat h = 0;
//
//    // Left side of the ratio view
//    x = 0;
//    y = 0;
//    w = self.maskView.x;
//    h = self.bgView.height;
//    CGPathAddRect(path, nil, CGRectMake(x,y,w,h));
//
//    // Right side of the ratio view
//    x = self.maskView.x + self.maskView.width;
//    y = 0;
//    w = self.bgView.width - x;
//    h = self.bgView.height;
//    CGPathAddRect(path, nil, CGRectMake(x,y,w,h));
//
//    // Top side of the ratio view
//    x = 0;
//    y = 0;
//    w = self.bgView.width;
//    h = self.maskView.y;
//    CGPathAddRect(path, nil, CGRectMake(x,y,w,h));
//
//    // Bottom side of the ratio view
//    x = 0;
//    y = self.maskView.y + self.maskView.height;
//    w = self.bgView.width;
//    h = self.bgView.height - y;
//    CGPathAddRect(path, nil, CGRectMake(x,y,w,h));
//
//    maskLayer.path = path;
//    self.overLayerView.layer.mask = maskLayer;
//    CGPathRelease(path);
}
@end
