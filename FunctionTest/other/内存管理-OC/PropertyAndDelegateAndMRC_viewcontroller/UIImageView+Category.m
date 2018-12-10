//
//  UIImageView+Category.m
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)
-(void)dealloc{
    NSLog(@"imageview dealloc:%p",self);
    [super dealloc];
}
@end
