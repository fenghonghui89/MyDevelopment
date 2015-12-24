//
//  MDCDefineViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//




//定义一个宏
//#define PI 3.1415926
const float PI = 3.1415926;//全局常量
/*
 区别：宏相当于字符串替换操作，内存中不存在；全局变量在内存中是存在的
 相同点：通常定义一个全局变量加const修饰符，全局变量的值是不可以改变的。宏对应替换的内容也是不可以改变的。
 */



#include "stdio.h"
#import "MDCDefineViewController.h"

@interface MDCDefineViewController ()

@end


@implementation MDCDefineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TODO:编译环境判断，判断当前开发时使用的sdk的版本
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    NSLog(@"ios8sdk编译");
#else
    NSLog(@"ios7sdk编译");
#endif
    
    //TODO:定义一个宏函数（注意参数是没有数据类型）
#define MIANJI(r) 3.1415926*r*r
#define CHENG(x,y) ((x)*(y))
#define UPPER(x) ((x)>='a'&&(x)<='z')?x-('a'-'A'):x
#define MAX1(x,y) ((x)>(y))?(x):(y)
    
#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)
    if (IsIOS8) {
        NSLog(@"这是ios8系统");
    }else{
        NSLog(@"这是ios7系统");
    }
    
#define DLog(fmt,...)   NSLog((@"[Method:%s]-[Line %d]->" fmt),__PRETTY_FUNCTION__, __LINE__,##__VA_ARGS__)
    DLog(@"这是DLog");
    
    //TODO:判断是真机还是模拟器
#if TARGET_OS_IPHONE
    NSLog(@"真机");
#endif
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"模拟器");
#endif
    
    //TODO:判断arc还是mrc
#if __has_feature(objc_arc)
    NSLog(@"arc");
#else 
    NSLog(@"mrc");
#endif
    
    
    //TODO:#x代表x的内容转换成字符串
#define STR(x) #x
#define fun(x) printf( "%s = %d\n", #x, x)
    printf(STR(11111111111\n));
    int m = 5;
    fun( m );

    //TODO:##运算符可以将标识与其它内容拼接在一起，成为新的标识
#define DEF(x) student##x
    int DEF(10) = 10;
    
    //TODO:c语言常用的宏
    NSLog(@"当前的行号:%d",__LINE__);
    NSLog(@"当前的文件名:%s",__FILE__);
    NSLog(@"当前的日期:%s",__DATE__);
    NSLog(@"当前的时间:%s"__TIME__);
}

//TODO:根据参数编译
-(void)define2
{
#define qidong @"启动"
  
#ifndef qidong
    NSLog(@"没有启动");
#else
    NSLog(@"启动");
#endif
}

//TODO:根据条件来进行编译/undef
-(void)define3
{
#define kaiqi @"开启"
    
#if defined(kaiqi)
    NSLog(@"开启");
#else
    NSLog(@"没开启");
#endif
    
#undef kaiqi
#if defined(kaiqi)
    NSLog(@"开启");
#else
    NSLog(@"没开启");
#endif
}

//TODO:根据宏值来进行编译
-(void)define4
{
#define value 3
    
#if value == 4
    NSLog(@"数值是4");
#else
    NSLog(@"数值不是4");
#endif
}

@end
