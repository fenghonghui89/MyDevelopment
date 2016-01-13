//
//  UILabel+Category.m
//  UIView
//
//  Created by hanyfeng on 14-4-28.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
-(void)dealloc{
    NSLog(@"label dealloc:%p",self);
    [super dealloc];
}
@end
