//
//  TRMyclass.m
//  my01
//
//  Created by apple on 13-10-24.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRMyclass1.h"
#import "TRMyclass1_TRExtension.h"

/*
扩展的方法是私有的，有两种方法：
1.在主类的实现部分声明扩展类和方法，方便查看.m文件时看到哪些是扩展方法
2.创建扩展类，import头文件
 */

//方法1：
@interface TRMyclass1 ()
//@property int age;
@property(nonatomic,assign)int age1;
-(void)methodExtension;//扩展方法
@end

/////////////////////////////////////////////////////////////////

@implementation TRMyclass1

-(void)methodMyclass
{
    NSLog(@"Myclass method");
}

//扩展方法
-(void)methodExtension
{
    NSLog(@"Extension method");
}


@end
