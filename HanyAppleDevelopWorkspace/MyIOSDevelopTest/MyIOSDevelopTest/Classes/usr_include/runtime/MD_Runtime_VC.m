//
//  MD_Runtime_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Runtime_VC.h"
#import <objc/runtime.h>
#import "DGCListInfo.h"
#import "AFNetworking.h"
#import "MD_Model.h"
#import "BadBoyModel.h"
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
/*
 initialize不是init
 运行时间的行为之一就是initialize。虽然看起来有点像大家常见的init，但是他们并不相同。
 在程序运行过程中，它会在你程序中每个类调用一次initialize。这个调用的时间发生在你的类接收到消息之前，但是在它的超类接收到initialize之后。
 */
-(void)test_initialize{
  
  /*
   如果你希望确定只用了initialize一次用来实现某些单独运行的工作，或者希望实现仅仅运行一次的方法，检查一下[self class]，才能确定是否是你希望做到的效果
   */
  
  
//  TRXYZ *xyz = [TRXYZ new];
//  TRPoint *p = [TRPoint new];
//  TRPoint *p1 = [TRPoint new];
//  
//  /*
//   2016-10-18 12:19:34.710666 MyIOSDevelopTest[583:104530] +[TRPoint initialize] [Line 23] TRPoint initialize
//   2016-10-18 12:19:34.710792 MyIOSDevelopTest[583:104530] +[TRXYZ initialize] [Line 23] TRXYZ initialize
//   2016-10-18 12:19:34.710918 MyIOSDevelopTest[583:104530] -[TRPoint init] [Line 30] TRXYZ init
//   2016-10-18 12:19:34.711009 MyIOSDevelopTest[583:104530] -[TRXYZ init] [Line 30] TRXYZ init
//   2016-10-18 12:19:34.711122 MyIOSDevelopTest[583:104530] -[TRPoint init] [Line 30] TRPoint init
//   2016-10-18 12:19:34.711215 MyIOSDevelopTest[583:104530] -[TRPoint init] [Line 30] TRPoint init
//   */
  
  
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

//遍历一个类的全部成员变量名及类型
-(void)test_showAllmemberVariable{

  unsigned int count = 0;
  
  /*
   Ivar:表示成员变量类型
   获得一个指向该类所有成员变量的指针
   */
  Ivar *ivars = class_copyIvarList([MDWeather class], &count);//
  
  for (int i =0; i < count; i ++) {
    
    Ivar ivar = ivars[i];
    
    const char *name = ivar_getName(ivar);
    NSString *nameStr = [NSString stringWithUTF8String:name];
    
    const char *type = ivar_getTypeEncoding(ivar);
    NSString *typeStr = [NSString stringWithUTF8String:type];
    
    NSLog(@"%@----%@",nameStr,typeStr);
  }
  
  free(ivars);
  /*
   2016-10-20 11:34:55.703083 MyIOSDevelopTest[1085:278138] _date----@"NSString"
   2016-10-20 11:34:55.703237 MyIOSDevelopTest[1085:278138] _week----@"NSString"
   2016-10-20 11:34:55.703324 MyIOSDevelopTest[1085:278138] _nongli----@"NSString"
   2016-10-20 11:34:55.703455 MyIOSDevelopTest[1085:278138] _info_day----@"NSArray"
   2016-10-20 11:34:55.703538 MyIOSDevelopTest[1085:278138] _info_night----@"NSArray"
   2016-10-20 11:34:55.703619 MyIOSDevelopTest[1085:278138] _point----@"TRPoint"
   */
}


//遍历一个类的全部属性名及类型
-(void)test_showAllProperty{

  unsigned int count = 0;
  objc_property_t *propertyList = class_copyPropertyList([MDWeather class], &count);
  
  for(int i = 0;i<count;i++){
    objc_property_t property = propertyList[i];
    
    const char *name = property_getName(property);
    NSString *nameStr = [NSString stringWithUTF8String:name];
    
    const char *type = property_getAttributes(property);
    NSString *typeStr = [NSString stringWithUTF8String:type];
    
    NSLog(@"%@ --- %@",nameStr,typeStr);
  }
  
  free(propertyList);
  /*
   2016-10-20 11:36:41.339529 MyIOSDevelopTest[1090:278689] date --- T@"NSString",C,N,V_date
   2016-10-20 11:36:41.339626 MyIOSDevelopTest[1090:278689] week --- T@"NSString",C,N,V_week
   2016-10-20 11:36:41.339713 MyIOSDevelopTest[1090:278689] nongli --- T@"NSString",C,N,V_nongli
   2016-10-20 11:36:41.339798 MyIOSDevelopTest[1090:278689] info_day --- T@"NSArray",&,N,V_info_day
   2016-10-20 11:36:41.339883 MyIOSDevelopTest[1090:278689] info_night --- T@"NSArray",&,N,V_info_night
   2016-10-20 11:36:41.339968 MyIOSDevelopTest[1090:278689] point --- T@"TRPoint",&,N,V_point
   */
}

//遍历一个类的全部实例方法
-(void)test_showAllMethod{

  unsigned int count = 0;
  Method *methods = class_copyMethodList([MDWeather class], &count);
  for(int i = 0; i<count;i++){
    Method method = methods[i];
    SEL selector = method_getName(method);
    const char *name = sel_getName(selector);
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


-(void)test_0{

  NSDictionary *dic = @{@"netName":@"Hany",@"netAge":@(12)};
  BadBoyModel *badBoy = [[BadBoyModel alloc] initWithDictionary:dic];
  [badBoy displayCurrentModleProperty];

}

#pragma mark - ************** action **************

- (IBAction)btnTap:(id)sender {
  
  [self test_showAllProperty];
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
