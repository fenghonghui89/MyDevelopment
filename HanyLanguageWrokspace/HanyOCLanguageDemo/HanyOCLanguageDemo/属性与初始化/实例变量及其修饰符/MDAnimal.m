//
//  MDAnimal.m
//  MyDevelopmentOC
//
//  Created by hanyfeng on 15/5/22.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "MDAnimal.h"

@implementation MDAnimal
{
    int _iimplement;
}

-(void)eat
{
    NSLog(@"动物吃");
    
    self->_i = 1;
    self->_ipackage = 1;
    self->_iprivate = 1;
    self->_iprotected = 1;
    self->_ipublic = 1;
    self->_iimplement = 1;
}

-(void)say
{
    NSLog(@"动物说");
}
@end
