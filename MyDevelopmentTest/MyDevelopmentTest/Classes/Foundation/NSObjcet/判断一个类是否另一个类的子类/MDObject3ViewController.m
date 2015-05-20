//
//  MDObject3ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDObject3ViewController.h"
#import "TRStudent3.h"
#import "TRPerson.h"
#import "TRCat.h"
@interface MDObject3ViewController ()

@end

@implementation MDObject3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Class abc = [TRPerson class];//1.创建父类的类对象
    BOOL b = [TRCat isSubclassOfClass:abc];//2.方法得出的是BOOL型变量
    //BOOL b = [TRStudent isSubclassOfClass:[TRPerson class]];//两种方式
    
    //if([TRStudent isSubclassOfClass:abc])也可以
    if (b) {//3.判断
        NSLog(@"是子类");
    }else{
        NSLog(@"不是子类");
    }
    
    NSLog(@"class address:%p",abc);//类不占用内存空间，但类对象占用内存空间
}


@end
