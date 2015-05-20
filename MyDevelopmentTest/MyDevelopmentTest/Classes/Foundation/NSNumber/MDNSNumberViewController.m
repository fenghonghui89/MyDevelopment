//
//  MDNSNumberViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSNumberViewController.h"

@interface MDNSNumberViewController ()

@end

@implementation MDNSNumberViewController

#warning 缺char的转换
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int i =18,i1;
    NSNumber* num = [NSNumber numberWithInt:i];
    NSLog(@"num:%@",num);
    i1 = [num intValue];
    NSLog(@"i1:%d",i1);
    
    char c = 'a';
    NSNumber* cha = [[NSNumber alloc]initWithChar:c];
    NSLog(@"cha:%@",cha);
    
    float f = 12.03,f1=0;
    NSNumber* flo = [[NSNumber alloc]initWithFloat:f];
    NSLog(@"flo:%@",flo);
    f1 = [flo floatValue];
    NSLog(@"f1:%f",f1);
}

@end
