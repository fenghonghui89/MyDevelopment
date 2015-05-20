//
//  MyGHUnitTest.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/12.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//


#import <GHUnitIOS/GHUnit.h>

#import "ViewController.h"
@interface MyGHUnitTest:GHTestCase

@end
@implementation MyGHUnitTest
-(void)setUp
{
    [super setUp];
}

-(void)tearDown
{
    [super tearDown];
}

-(void)setUpClass
{
    [super setUpClass];
}

-(void)tearDownClass
{
    [super tearDownClass];
}

-(void)testUI
{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    ViewController *vc = [[ViewController alloc] init];
    [keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}
@end
