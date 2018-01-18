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
@end
