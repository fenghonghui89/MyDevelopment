//
//  MD_AFNetwork_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/30.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_AFNetwork_VC.h"
#import "AFNetworking.h"
#import "DGCUserManager.h"
#import "MDTool.h"
#import "MDDefine.h"
@interface MD_AFNetwork_VC()<DGCUserManagerDelegate>

@end

@implementation MD_AFNetwork_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self af_manager];
}
#pragma mark - < method > -
-(void)af_get{
  //天气
  //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  //    [manager GET:@"http://webservice.webxml.com.cn//webservices/DomesticAirline.asmx/getDomesticCity?"
  //      parameters:nil
  //         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
  //             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
  //             NSLog(@"me JSON: %@", dic);
  //         }
  //         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
  //             NSLog(@"error..");
  //         }];
  
  //天工问答登录
  NSString *requestURL = @"http://api.wd.tgnet.com/Info/NewestList";
  NSDictionary *paraDic = @{@"class_no":@"",
                            @"page":@(1),
                            @"limit":@(10)
                            };
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  [manager GET:requestURL
    parameters:paraDic
       success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"me JSON: %@", dic);
       }
       failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         NSLog(@"error..");
       }];

}

-(void)af_post{
  NSString *requestURL = @"http://51uca.com/biz/login";
  
  NSString *md5_password = [MDTool md5:@"12345678"];
  NSString *md5_tmp = [md5_password stringByAppendingString:@"rickyhoxiaoyi@163.com"];
  NSString *md5_final = [MDTool md5:md5_tmp];
  NSDictionary *paraDic = @{@"username":@"rickyhoxiaoyi@163.com",
                            @"password":md5_final,
                            @"sysModel":@(1),
                            };
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  [manager POST:requestURL parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"me JSON: %@", dic);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"me Error: %ld\n%@",(long)error.code,error.domain);
    
  }];
}

-(void)af_Reachability{

  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    NSLog(@"me - network change status:%ld",(long)status);
  }];
  [manager startMonitoring];

}

-(void)af_manager{
  
  //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //    NSLog(@"%@",manager.baseURL);
  
  NSDictionary *userinfo = [NSDictionary dictionaryWithObject:@"login" forKey:@"userinfo"];
  
  [[DGCUserManager share] loginByUsername:@"rickyhoxiaoyi@163.com"
                                 password:@"1234567"
                                 sysmodel:1
                                 userinfo:userinfo
                                 delegate:self];
}

#pragma mark - < action > -

#pragma mark - < callback > -
-(void)DGCLogin:(DGCUserManager *)userServices isSuccess:(BOOL)isSuccess data:(DGCUserInfo *)data errorCode:(DGCRequestErrorCode)code msg:(NSString *)msg userInfo:(NSDictionary *)userInfo{
  
  if (isSuccess) {
    NSLog(@"登录成功:%@",data);
  }else{
    NSLog(@"登录失败:%ld %@",(long)code,msg);
    
  }
}
@end
