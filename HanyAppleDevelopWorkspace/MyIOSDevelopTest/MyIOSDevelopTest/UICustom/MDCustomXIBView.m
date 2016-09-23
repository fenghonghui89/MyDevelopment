//
//  MDCustomView.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDCustomXIBView.h"

@interface MDCustomXIBView ()

@end

IB_DESIGNABLE
@implementation MDCustomXIBView

- (void)setCornerRadius:(CGFloat)cornerRadius{
  _cornerRadius = cornerRadius;
  self.layer.cornerRadius  = _cornerRadius;
  self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
  _bcolor = bcolor;
  self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
  _bwidth = bwidth;
  self.layer.borderWidth = _bwidth;
}

@end
