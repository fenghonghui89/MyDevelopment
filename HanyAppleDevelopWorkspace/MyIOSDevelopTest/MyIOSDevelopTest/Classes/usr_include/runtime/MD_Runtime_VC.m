//
//  MD_Runtime_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 initialize不是init
 运行时间的行为之一就是initialize。虽然看起来有点像大家常见的init，但是他们并不相同。
 在程序运行过程中，它会在你程序中每个类调用一次initialize。这个调用的时间发生在你的类接收到消息之前，但是在它的超类接收到initialize之后。
 */
#import "MD_Runtime_VC.h"
#import <objc/runtime.h>
#import "DGCListInfo.h"
#import "AFNetworking.h"
#import "MD_Model.h"
@interface MD_Runtime_VC ()

@end
@implementation MD_Runtime_VC

#pragma mark - ************** override **************
#pragma mark - < vc lifecycle >
-(void)viewDidLoad{

  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];

}

#pragma mark - ************** method **************
-(void)test_initialize{
  
  /*
   如果你希望确定只用了initialize一次用来实现某些单独运行的工作，或者希望实现仅仅运行一次的方法，检查一下[self class]，才能确定是否是你希望做到的效果
   */
  
  
  TRXYZ *xyz = [TRXYZ new];
  TRPoint *p = [TRPoint new];
  TRPoint *p1 = [TRPoint new];
  
  /*
   2016-10-18 12:19:34.710666 MyIOSDevelopTest[583:104530] +[TRPoint initialize] [Line 23] TRPoint initialize
   2016-10-18 12:19:34.710792 MyIOSDevelopTest[583:104530] +[TRXYZ initialize] [Line 23] TRXYZ initialize
   2016-10-18 12:19:34.710918 MyIOSDevelopTest[583:104530] -[TRPoint init] [Line 30] TRXYZ init
   2016-10-18 12:19:34.711009 MyIOSDevelopTest[583:104530] -[TRXYZ init] [Line 30] TRXYZ init
   2016-10-18 12:19:34.711122 MyIOSDevelopTest[583:104530] -[TRPoint init] [Line 30] TRPoint init
   2016-10-18 12:19:34.711215 MyIOSDevelopTest[583:104530] -[TRPoint init] [Line 30] TRPoint init
   */
  
  
//  TRPoint *p = [TRPoint new];
//  TRPoint *p1 = [TRPoint new];
//  TRXYZ *xyz = [TRXYZ new];
//  
//  /*
//   2016-10-18 12:15:47.648642 MyIOSDevelopTest[576:103275] +[TRPoint initialize] [Line 23] TRPoint initialize
//   2016-10-18 12:15:47.648792 MyIOSDevelopTest[576:103275] -[TRPoint init] [Line 30] TRPoint init
//   2016-10-18 12:15:47.648889 MyIOSDevelopTest[576:103275] -[TRPoint init] [Line 30] TRPoint init
//   2016-10-18 12:15:47.649015 MyIOSDevelopTest[576:103275] +[TRXYZ initialize] [Line 23] TRXYZ initialize
//   2016-10-18 12:15:47.649122 MyIOSDevelopTest[576:103275] -[TRPoint init] [Line 30] TRXYZ init
//   2016-10-18 12:15:47.649212 MyIOSDevelopTest[576:103275] -[TRXYZ init] [Line 30] TRXYZ init
//   */
}

//遍历一个类的全部成员变量
-(void)test_showAllmemberVariable{

  unsigned int count = 0;
  
  //Ivar:表示成员变量类型
  Ivar *ivars = class_copyIvarList([DGCListInfo class], &count);//获得一个指向该类所有成员变量的指针
  
  for (int i =0; i < count; i ++) {
    
    Ivar ivar = ivars[i];
    const char *name = ivar_getName(ivar);//根据ivar获得其成员变量的名称--->C语言的字符串
    NSString *key = [NSString stringWithUTF8String:name];
    NSLog(@"%d----%@",i,key);
  }
}


//遍历一个类的全部属性
-(void)test_showAllProperty{

  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList([DGCListInfo class], &count);//获得一个指向该类所有属性的指针
  
  for (int i = 0; i<count; i++) {
    objc_property_t property = properties[i];
    const char *name = property_getName(property);//根据objc_property_t获得其属性的名称--->C语言的字符串
    NSString *key = [NSString stringWithUTF8String:name];
    NSLog(@"%d----%@",i,key);

  }
}

//交换方法 - 数组添加nil不会崩溃(要打开NSMutableArray+Extension开关)
-(void)test_changeMethod{

  NSMutableArray *array = [NSMutableArray array];
  [array addObject:@"1"];
  [array addObject:@"2"];
  [array addObject:nil];
  DRLog(@"%@",array);//1,2
}

//快速归档反归档
-(void)test_arch{

  //request
  NSString *bodyString = @"cityname=北京&dtype=json&key=31d9b0a8a3e3d4086ad3c6dd1bfeb7ed";
  [bodyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
  NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://op.juhe.cn/onebox/weather/query"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:bodyData];
  
  //af
  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:conf];
  AFHTTPResponseSerializer *respon = [AFHTTPResponseSerializer serializer];
  respon.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  manager.responseSerializer = respon;
  
  NSURLSessionTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      DRLog(@"error response..:%@",respon);
    }else{
      NSError *dataError = nil;
      NSDictionary *data = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingAllowFragments error:&dataError];
      if (dataError) {
        DRLog(@"dateError response..:%@",response);
      }else{
        //parse
        NSArray *arr = [[[data objectForKey:@"result"] objectForKey:@"data"] objectForKey:@"weather"];
        NSMutableArray *dataArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          MDWeather *weather = [MDWeather parseByData:obj];
          [dataArr addObject:weather];
        }];
        
        //log
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          MDWeather *weather = (MDWeather *)obj;
          DRLog(@"data..%@",[weather.info_night objectAtIndex:1]);
        }];
        
        //save to localstore
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        path = [path stringByAppendingString:@"/weathers"];
        BOOL b = [NSKeyedArchiver archiveRootObject:dataArr toFile:path];
        if (b) {
          DRLog(@"save success..");
        }else{
          DRLog(@"save error..");
        }
      }
    }
  }];
  [task resume];
  

}


#pragma mark - ************** action **************

- (IBAction)btnTap:(id)sender {
  
  [self test_arch];
}

- (IBAction)btn1Tap:(id)sender {
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/weathers"];
  NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  if (data) {
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      MDWeather *weather = (MDWeather *)obj;
      DRLog(@"data..%@",[weather.info_night objectAtIndex:1]);
    }];
  }else{
    DRLog(@"data load error..");
  }

}
@end
