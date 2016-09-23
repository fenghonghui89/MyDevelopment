//
//  OCViewController.m
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/3.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "OCViewController.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  

}

/*
 CF_RETURNS_RETAINED or CF_RETURNS_NOT_RETAINED
 见 ViewController_3_WorkingWithCocoaDataTypes - Core Foundataion
 */
-(CGPathRef)makeToPath CF_RETURNS_RETAINED{
  
  UIBezierPath* triangle = [UIBezierPath bezierPath];
  [triangle moveToPoint:CGPointZero];
  [triangle addLineToPoint:CGPointMake(self.view.frame.size.width,0)];
  [triangle addLineToPoint:CGPointMake(0, self.view.frame.size.height)];
  [triangle closePath];
  CGPathRef theCGPath = [triangle CGPath];
  return CGPathCreateCopy(theCGPath);
}
@end
