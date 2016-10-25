//
//  MD_Runtime_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Runtime_VC.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "DGCListInfo.h"
#import "AFNetworking.h"
#import "MD_Model.h"
#import "YYModel.h"
#import "NSMutableArray+Extension.h"
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
-(void)test_showAllmemberVariable_nameAndType{

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
   2016-10-21 17:50:51.502280 MyIOSDevelopTest[1762:438990] _date----@"NSString"
   2016-10-21 17:50:51.502468 MyIOSDevelopTest[1762:438990] _week----@"NSString"
   2016-10-21 17:50:51.502559 MyIOSDevelopTest[1762:438990] _nongli----@"NSString"
   2016-10-21 17:50:51.502707 MyIOSDevelopTest[1762:438990] _info_day----@"NSArray"
   2016-10-21 17:50:51.502795 MyIOSDevelopTest[1762:438990] _info_night----@"NSArray"
   2016-10-21 17:50:51.502877 MyIOSDevelopTest[1762:438990] _point----@"TRPoint"
   2016-10-21 17:50:51.502960 MyIOSDevelopTest[1762:438990] _testIntValue----q
   */
}


//遍历一个类的全部属性名及类型
-(void)test_showAllProperty__nameAndType{

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
   2016-10-21 17:52:05.455139 MyIOSDevelopTest[1768:439617] date --- T@"NSString",C,N,V_date
   2016-10-21 17:52:05.455331 MyIOSDevelopTest[1768:439617] week --- T@"NSString",C,N,V_week
   2016-10-21 17:52:05.455425 MyIOSDevelopTest[1768:439617] nongli --- T@"NSString",C,N,V_nongli
   2016-10-21 17:52:05.455512 MyIOSDevelopTest[1768:439617] info_day --- T@"NSArray",&,N,V_info_day
   2016-10-21 17:52:05.455597 MyIOSDevelopTest[1768:439617] info_night --- T@"NSArray",&,N,V_info_night
   2016-10-21 17:52:05.455683 MyIOSDevelopTest[1768:439617] point --- T@"TRPoint",&,N,V_point
   2016-10-21 17:52:05.455837 MyIOSDevelopTest[1768:439617] testIntValue --- Tq,N,V_testIntValue
   */
}

//遍历一个类的全部实例方法
-(void)test_showAllMethod_name{

  unsigned int count = 0;
  Method *methods = class_copyMethodList([MDWeather class], &count);
  for(int i = 0; i<count;i++){
    Method method = methods[i];
    SEL selector = method_getName(method);
    const char *name = sel_getName(selector);
    NSString *key = [NSString stringWithUTF8String:name];
    NSLog(@"%d----%@",i,key);
  }
  
  /*
   2016-10-21 18:00:12.289961 MyIOSDevelopTest[1780:441564] 0----displayCurrentModleProperty
   2016-10-21 18:00:12.290145 MyIOSDevelopTest[1780:441564] 1----setNongli:
   2016-10-21 18:00:12.290230 MyIOSDevelopTest[1780:441564] 2----setInfo_day:
   2016-10-21 18:00:12.290308 MyIOSDevelopTest[1780:441564] 3----setInfo_night:
   2016-10-21 18:00:12.290493 MyIOSDevelopTest[1780:441564] 4----nongli
   2016-10-21 18:00:12.290570 MyIOSDevelopTest[1780:441564] 5----info_day
   2016-10-21 18:00:12.290645 MyIOSDevelopTest[1780:441564] 6----info_night
   2016-10-21 18:00:12.290720 MyIOSDevelopTest[1780:441564] 7----testIntValue
   2016-10-21 18:00:12.290795 MyIOSDevelopTest[1780:441564] 8----setTestIntValue:
   2016-10-21 18:00:12.290871 MyIOSDevelopTest[1780:441564] 9----.cxx_destruct
   2016-10-21 18:00:12.290946 MyIOSDevelopTest[1780:441564] 10----date
   2016-10-21 18:00:12.291019 MyIOSDevelopTest[1780:441564] 11----point
   2016-10-21 18:00:12.291092 MyIOSDevelopTest[1780:441564] 12----setDate:
   2016-10-21 18:00:12.291167 MyIOSDevelopTest[1780:441564] 13----setPoint:
   2016-10-21 18:00:12.291949 MyIOSDevelopTest[1780:441564] 14----week
   2016-10-21 18:00:12.292032 MyIOSDevelopTest[1780:441564] 15----setWeek:
   */
}

//交换方法的实现
-(void)test_changeMethod{

  //数组添加nil不会崩溃(要打开NSMutableArray+Extension开关)
  NSMutableArray *array = [NSMutableArray array];
  [array addObject:@"1"];
  [array addObject:@"2"];
//  [array addObject:nil];//本来会崩，交换后不会
  [array addObjectCanNil:nil];//提出成原来的官方实现，所以会崩
  DRLog(@"%@",array);//1,2
  
  /*
   其他例子，看UINaviagtionController - 跳转
   注意被交换的方法内部会有递归调用，不用在意，因为已经交换了方法实现
   */

}

-(void)test_AddMethod{

  //添加方法
  IMP myIMP = imp_implementationWithBlock(^(id _self, NSString *string) {
    NSLog(@"Hello %@", string);
  });
  class_addMethod([TRPoint class], @selector(sayHello:), myIMP, "v@:@");
  
  
  //测试
  SEL sel = @selector(sayHello:);
  if ([TRPoint instancesRespondToSelector:sel]) {
    [[TRPoint new] performSelector:sel withObject:@"你好"];
  }else{
    DRLog(@"no sel..");
  }
}


//快速归档反归档
-(void)test_arch{
  
  //看存储 - 归档与反归档（运用YYModel）
}

//查看某个对象的全部属性的值
-(void)test_getAllPropertiesValue{

//  NSDictionary *dic = @{@"netName":@"Hany",@"netAge":@(12)};
//  BadBoyModel *badBoy = [[BadBoyModel alloc] initWithDictionary:dic];
//  [badBoy displayCurrentModleProperty];
  
  NSString *urlString = @"http://op.juhe.cn/onebox/weather/query?cityname=北京&dtype=json&key=31d9b0a8a3e3d4086ad3c6dd1bfeb7ed";
  urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  DRLog(@"url..%@",urlString);
  
  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:conf];
  AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
  responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];//application/json;charset=utf-8会报错
  manager.responseSerializer = responseSerializer;
  
  NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      NSLog(@"error response:%@",response);
    }else{
      NSError *dataError = nil;
      NSDictionary *data = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingAllowFragments error:&dataError];
      if (dataError) {
        DRLog(@"dateError response..:%@",response);
      }else{
        
        NSArray *arr = [[[data objectForKey:@"result"] objectForKey:@"data"] objectForKey:@"weather"];
        DRLog(@"get arr count..%lu",(unsigned long)arr.count);
        
        MDWeather *weather = [MDWeather yy_modelWithJSON:[arr objectAtIndex:0]];
        DRLog(@"weather..%@",weather);
        [weather displayCurrentModleProperty];
      }
    }
  }];
  [dataTask resume];

}

#pragma mark - ************** action **************

- (IBAction)btnTap:(id)sender {
  
  [self test_AddMethod];
  
}

- (IBAction)btn1Tap:(id)sender {
  

}
@end
