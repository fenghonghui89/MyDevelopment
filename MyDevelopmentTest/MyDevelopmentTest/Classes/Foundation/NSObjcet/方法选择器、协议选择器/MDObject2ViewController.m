//
//  MDObject2ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDObject2ViewController.h"
#import "TRStudent2.h"
#import "TRCat.h"
#import "TRFly.h"
#import "TRSuperman.h"
@interface MDObject2ViewController ()

@end

@implementation MDObject2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self methodSelector];
    [self protocolSelector];
}

//方法选择器
-(void)methodSelector
{
    TRStudent2* student = [TRStudent2 new];
    
    SEL abc = @selector(study);//SEL是类型，abc是引用名,相当于一个方法的指针
    NSLog(@"SEL address:%p",abc);
    
    BOOL b = [TRStudent2 instancesRespondToSelector:abc];
    //选择方法时要细心，这里用的是ToSelector，有另外一个方法名是ForSelector
    
    if (b) {
        NSLog(@"有这个方法");
        [student performSelector:abc];
        [student study];
        //区别：[student study]运行时编译器不会验证，而是直接运行，可能会有风险
    }else{
        NSLog(@"没有这个方法");
    }
}

//协议选择器
-(void)protocolSelector
{
    Protocol* p =@protocol(TRFly);//定义一个协议类型的指引指向协议
    BOOL b1 = [TRSuperman conformsToProtocol:p];
    if (b1) {
        NSLog(@"遵守了协议");
    }else{
        NSLog(@"未遵守协议");
    }
}
@end
