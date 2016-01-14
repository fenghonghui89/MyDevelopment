//
//  PPTextField.m
//  SDK_DEMO
//
//  Created by chenjunhong on 13-4-12.
//  Copyright (c) 2013年 1. All rights reserved.
//
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#import "PPTextField.h"

@implementation PPTextField

- (id)init
{
    self = [super init];
    if (self) {


    }
    return self;
}




- (void)awakeFromNib
{
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.size.width - 25 - 7 , bounds.origin.y + 25 - 15, 25, 25);
}




@end
