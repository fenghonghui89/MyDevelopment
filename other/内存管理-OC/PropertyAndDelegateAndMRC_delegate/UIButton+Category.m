//
//  UIButton+Category.m
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)
-(void)dealloc{
    NSLog(@"button dealloc:%p",self);
    [super dealloc];
}
@end
