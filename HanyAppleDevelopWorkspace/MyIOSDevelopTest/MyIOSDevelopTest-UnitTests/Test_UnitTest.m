//
//  Test1.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/2/20.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MD_FreeTest_VC.h"
#import "MD_AFNetwork_VC.h"


//通过扩展 测试私有属性或方法
@interface MD_FreeTest_VC (UnitTest)
-(NSInteger)test0;
@end

@interface Test_UnitTest : XCTestCase
@property(nonatomic,strong)MD_FreeTest_VC *vc_freetest;
@property(nonatomic,strong)MD_AFNetwork_VC *vc_af;
@end

@implementation Test_UnitTest

#pragma mark - < overwrite >
- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  
  self.vc_af = [MD_AFNetwork_VC new];
  self.vc_freetest = [MD_FreeTest_VC new];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  
  self.vc_af = nil;
  self.vc_freetest = nil;
  
  [super tearDown];
}




#pragma mark - < method >

#pragma mark * 单独测试方法
-(void)testUnit_afpost{
  [self.vc_af af_post_json];
}

#pragma mark * 单独测试方法性能
- (void)testPerformance_afpost{
  
  [self measureBlock:^{
    [self.vc_af af_post_json];
  }];
}

#pragma mark * 通过扩展 测试私有属性或方法
-(void)test_freetest{
  
  [self measureBlock:^{
    NSInteger result = [self.vc_freetest test0];
    XCTAssertEqual(result, 100,@"oh no!!!");
  }];
}

#pragma mark * 异步测试
-(void)test_asy{
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"GET Baidu"];
  
  NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    // XCTestExpectation条件已满足，接下来的测试可以执行了。
    [expectation fulfill];
    
    XCTAssertNotNil(data, @"返回数据不应非nil");
    XCTAssertNil(error, @"error应该为nil");
    
    if (response != nil) {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      XCTAssertEqual(httpResponse.statusCode, 200, @"HTTPResponse的状态码应该是200");
      XCTAssertEqual(httpResponse.URL.absoluteString, url.absoluteString, @"HTTPResponse的URL应该与请求的URL一致");
    } else {
      XCTFail(@"返回内容不是NSHTTPURLResponse类型");
    }
  }];
  [task resume];
  
  // 超时后执行 要写在最后
  [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
    [task cancel];
  }];
}

@end
