//
//  MDCat.m
//  MyDevelopmentOC
//
//  Created by hanyfeng on 15/5/22.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "MDCat.h"

@implementation MDCat

-(void)eat
{
    [super eat];
    NSLog(@"猫吃鱼");
    
    self->_i = 1;
    self->_ipackage = 1;
//    self->_iprivate = 1;
    self->_iprotected = 1;
    self->_ipublic = 1;
//    self->_iimplement = 1;
}
@end
