//
//  MD_AFNetwork_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/30.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
#import "GDataXMLNode.h"
#import "MD_AFNetwork_VC.h"
#import "AFNetworking.h"
#import "DGCUserManager.h"
#import "DGCPostManager.h"
#import "MDTool.h"
#import "MDDefine.h"
@interface MD_AFNetwork_VC()<DGCUserManagerDelegate,DGCPostManagerDelegate>

@end

@implementation MD_AFNetwork_VC

#pragma mark - ********** override **********
#pragma mark - view lifecycle
- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
}

#pragma mark - ********** customize method **********
#pragma mark - get
//全国城市
-(void)af_get_allCity{

  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  [manager GET:@"http://webservice.webxml.com.cn//webservices/DomesticAirline.asmx/getDomesticCity?"
    parameters:nil
       success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         
         //原来的xml
         NSString *xmlStr = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"原始xml:\n%@", xmlStr);
         
         //根据xml解析
         NSError *error = nil;
         GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:(NSData *)responseObject options:0 error:&error];
         if (error) {
           NSLog(@"xml parse error:%@",error.localizedDescription);
         }else{
           GDataXMLElement *root = document.rootElement;
           GDataXMLElement *diffgr = [[root elementsForName:@"diffgr:diffgram"] lastObject];
           GDataXMLElement *Airline1 = [[diffgr elementsForName:@"Airline1"] lastObject];
           NSArray *citys = [Airline1 elementsForName:@"Address"];
           for (GDataXMLElement *city in citys) {
             GDataXMLElement *enCityName = [[city elementsForName:@"enCityName"] lastObject];
             GDataXMLElement *cnCityName = [[city elementsForName:@"cnCityName"] lastObject];
             GDataXMLElement *Abbreviation = [[city elementsForName:@"Abbreviation"] lastObject];
             NSLog(@"%@ %@ %@",enCityName.stringValue,cnCityName.stringValue,Abbreviation.stringValue);
           }
         }
       }
       failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         NSLog(@"error:%@",error.localizedDescription);
       }];
}

//天工问答消息列表
-(void)af_get_TianGongNewes{

  NSString *requestURL = @"http://api.wd.tgnet.com/Info/NewestList";
  NSDictionary *paraDic = @{@"class_no":@"",
                            @"page":@(1),
                            @"limit":@(10)
                            };
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
  //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  [manager GET:requestURL
    parameters:paraDic
       success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         NSLog(@"success:\n%@", (NSDictionary *)responseObject);
       }
       failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         NSLog(@"error:%@",error.localizedDescription);
       }];

}



#pragma mark - post
//优嫁login
-(void)af_post_ucaLogin{
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
    NSLog(@"me Error:\n%@",error.localizedDescription);
    
  }];
}

#pragma mark - Reachability
-(void)af_Reachability{

  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    NSLog(@"me - network change status:%ld",(long)status);
  }];
  [manager startMonitoring];

}

#pragma mark - manager
-(void)af_manager_uca{
  
  //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //    NSLog(@"%@",manager.baseURL);
  
  NSDictionary *userinfo = [NSDictionary dictionaryWithObject:@"login" forKey:@"userinfo"];
  
  [[DGCUserManager share] loginByUsername:@"rickyhoxiaoyi@163.com"
                                 password:@"1234567"
                                 sysmodel:1
                                 userinfo:userinfo
                                 delegate:self];
}

//90days postlist
-(void)af_manager_90days{
  
  NSDictionary *delegateInfo = [NSDictionary dictionaryWithObject:FIRST_GET_INFO forKey:DELEGATE_INFO_KEY];
  [[DGCPostManager share] getPostsBySince:0 before:0 per_page:0 site:0 location:0 place:0 type:0 user:0 userinfo:delegateInfo delegate:self];
}

#pragma mark - upload
-(void)af_uploadImg_90days{
  
  UIImage *img = [UIImage imageNamed:@"000.jpg"];
  NSData *imgData = UIImageJPEGRepresentation(img, 0.3);
  
  NSString *urlStr = [NSString stringWithFormat:@"https://120.26.213.94/posts/%@/images",@"175"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
  [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPMethod:@"POST"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setHTTPBody:imgData];
  
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  operation.securityPolicy.allowInvalidCertificates = YES;
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Success: %@", responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"failuer :%@",error);
  }];
  [[NSOperationQueue mainQueue] addOperations:@[operation] waitUntilFinished:NO];
}


#pragma mark - ********** callback **********
-(void)DGCLogin:(DGCUserManager *)userServices isSuccess:(BOOL)isSuccess data:(DGCUserInfo *)data errorCode:(DGCRequestErrorCode)code msg:(NSString *)msg userInfo:(NSDictionary *)userInfo{
  
  if (isSuccess) {
    NSLog(@"登录成功:%@",data);
  }else{
    NSLog(@"登录失败:%ld %@",(long)code,msg);
    
  }
}

-(void)DGCPosts:(DGCPostManager *)userServices isSuccess:(BOOL)isSuccess data:(DGCListInfo *)data errorCode:(DGCRequestErrorCode)code msg:(NSString *)msg userInfo:(NSDictionary *)userInfo{
  
  NSString *identifier = [userInfo objectForKey:DELEGATE_INFO_KEY];
  if (isSuccess) {
    
    if ([identifier isEqualToString:FIRST_GET_INFO]) {
      NSArray *arr = data.items;
      DLog(@"成功 %@",arr);
    }
  }else{
    DLog(@"失败 %@",msg);
  }
}
@end
