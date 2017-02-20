//
//  Test0.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/2/20.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MD_FreeTest_VC.h"
@interface Test_FreeTest : XCTestCase
@property(nonatomic,strong)MD_FreeTest_VC *vc;
@end

@implementation Test_FreeTest

#pragma mark - < overwrite >
- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  
  self.vc = [MD_FreeTest_VC new];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  
  self.vc = nil;
  [super tearDown];
}

- (void)testExample {
  // This is an example of a functional test case.
  // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
  // This is an example of a performance test case.
  [self measureBlock:^{
    // Put the code you want to measure the time of here.
  }];
}

#pragma mark - < method >
-(void)test测试公开方法{
  [self.vc test1];
}
@end
