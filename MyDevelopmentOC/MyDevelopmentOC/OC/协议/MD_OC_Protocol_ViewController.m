//
//  MD_OC_Protocol_ViewController.m
//  MyDevelopmentOC
//
//  Created by hanyfeng on 15/5/25.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "MD_OC_Protocol_ViewController.h"
#import "TRMyclass.h"
#import "TRProtocol.h"
#import "TRProtocol2.h"
#import "TRProtocol3.h"
@interface MD_OC_Protocol_ViewController ()

@end

@implementation MD_OC_Protocol_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self protocolTest];
}

-(void)protocolTest
{
    TRMyClass* myClass = [[TRMyClass alloc]init];
    id<TRProtocol2,TRProtocol3> p = myClass;
    [p method1];
    [p method2];
    [p method3];
    [p method5];
    [p method6];
    //[p method4];//只能发送协议要求的方法
    
    //判断对象是否遵守协议
    BOOL b = [p conformsToProtocol:@protocol(TRProtocol)];
    if(b == YES){
        NSLog(@"遵守了协议");
    }
}

@end
