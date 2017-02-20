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
#import "MDRootDefine.h"
#import "MDAlertController.h"

@interface MD_AFNetwork_VC()<DGCUserManagerDelegate,DGCPostManagerDelegate>

@end

@implementation MD_AFNetwork_VC

#pragma mark - < override >
#pragma mark - * view lifecycle
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
}

#pragma mark - < customize method >
#pragma mark - * get
//http://www.webxml.com.cn 国内航班 - 全国城市
-(void)af_get_allCity{

  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://webservice.webxml.com.cn/webservices/DomesticAirline.asmx/getDomesticCity?"]];

  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:conf];
  AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
  responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
  manager.responseSerializer = responseSerializer;
  
  NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      NSLog(@"error response:%@",response);
    }else{
      //原始xml
      NSLog(@"success response:\n%@\n httpHeaderFields:\n%@\n",response,request.allHTTPHeaderFields);
      
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
          
          NSString *result = [NSString stringWithFormat:@"%@ %@ %@",enCityName.stringValue,cnCityName.stringValue,Abbreviation.stringValue];
          MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:result];
          [self.navigationController pushViewController:ac animated:nil];
        }
      }
    }
  }];
  [dataTask resume];

}



//聚合数据 - 天气预报 - get
-(void)af_get_json{

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
      DRLog(@"error response:%@",[error localizedDescription]);
      MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[error localizedDescription]];
      [self.navigationController pushViewController:ac animated:nil];
    }else{
      NSError *dataError = nil;
      NSDictionary *data = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingAllowFragments error:&dataError];
      if (dataError) {
        DRLog(@"dateError response..:%@",[dataError localizedDescription]);
        MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[dataError localizedDescription]];
        [self.navigationController pushViewController:ac animated:nil];
      }else{
        
        NSArray *arr = [[data objectForKey:@"result"] objectForKey:@"data"];
        NSString *result = [NSString stringWithFormat:@"get arr count..%lu",(unsigned long)arr.count];
        DRLog(@"get arr count..%lu",(unsigned long)arr.count);
        
        MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:result];
        [self.navigationController pushViewController:ac animated:nil];
      }
    }
  }];
  [dataTask resume];

}

#pragma mark - * post
//聚合数据 - 天气预报 - post
-(void)af_post_json{
  
  NSString *bodyString = @"cityname=北京&dtype=json&key=31d9b0a8a3e3d4086ad3c6dd1bfeb7ed";
  [bodyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
  NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://op.juhe.cn/onebox/weather/query"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:bodyData];
  
  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:conf];
  AFHTTPResponseSerializer *respon = [AFHTTPResponseSerializer serializer];
  respon.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  manager.responseSerializer = respon;
  
  NSURLSessionTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      DRLog(@"error response:%@",[error localizedDescription]);
      MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[error localizedDescription]];
      [self.navigationController pushViewController:ac animated:nil];
    }else{
      NSError *dataError = nil;
      NSDictionary *data = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingAllowFragments error:&dataError];
      if (dataError) {
        DRLog(@"dateError response..:%@",[dataError localizedDescription]);
        MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[dataError localizedDescription]];
        [self.navigationController pushViewController:ac animated:nil];
      }else{
        NSArray *arr = [[data objectForKey:@"result"] objectForKey:@"data"];
        NSString *result = [NSString stringWithFormat:@"post arr count..%lu",(unsigned long)arr.count];
        DRLog(@"post arr count..%lu",(unsigned long)arr.count);
        
        MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:result];
        [self.navigationController pushViewController:ac animated:nil];
      }
    }
  }];
  [task resume];
}

//自己搭建php服务器
-(void)af_post_myself{
  
  NSString *bodyString = @"a=get_users&uid=10001";
  [bodyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
  NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://192.168.3.169/PHP_MyServer.php"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:bodyData];
  
  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:conf];
  AFHTTPResponseSerializer *respon = [AFHTTPResponseSerializer serializer];
  respon.acceptableContentTypes = [NSSet setWithObject:@"application/json"];//php服务器默认是text/xml，要用application/json的话服务端要修改header('Content-Type: application/json');
  manager.responseSerializer = respon;
  
  NSURLSessionTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      DRLog(@"error response:%@",[error localizedDescription]);
      MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[error localizedDescription]];
      [self.navigationController pushViewController:ac animated:nil];
    }else{
      NSError *dataError = nil;
      NSDictionary *data = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingAllowFragments error:&dataError];
      if (dataError) {
        DRLog(@"dateError response..:%@",[dataError localizedDescription]);
        MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[dataError localizedDescription]];
        [self.navigationController pushViewController:ac animated:nil];
      }else{
        DRLog(@"success data:%@",data);
        MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:[data description]];
        [self.navigationController pushViewController:ac animated:nil];
      }
    }
  }];
  [task resume];
}

#pragma mark - * Reachability
-(void)af_Reachability{

  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    DRLog(@"me - network change status:%ld",(long)status);
    NSString *result = [NSString stringWithFormat:@"me - network change status:%ld",(long)status];
    MDAlertController *ac = [MDAlertController alertDefaultControllerWithMessage:result];
    [self.navigationController pushViewController:ac animated:nil];
  }];
  [manager startMonitoring];

}

#pragma mark - * manager
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

#pragma mark - * upload
-(void)af_uploadImg_90days{
  
//  UIImage *img = [UIImage imageNamed:@"000.jpg"];
//  NSData *imgData = UIImageJPEGRepresentation(img, 0.3);
//  
//  NSString *urlStr = [NSString stringWithFormat:@"https://120.26.213.94/posts/%@/images",@"175"];
//  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//  [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
//  [request setHTTPMethod:@"POST"];
//  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//  [request setHTTPBody:imgData];
//  
//  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//  operation.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//  operation.securityPolicy.allowInvalidCertificates = YES;
//  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSLog(@"Success: %@", responseObject);
//  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSLog(@"failuer :%@",error);
//  }];
//  [[NSOperationQueue mainQueue] addOperations:@[operation] waitUntilFinished:NO];
}

#pragma mark - < action >
- (IBAction)btnTap:(id)sender {
  [self af_post_myself];
}

- (IBAction)btn1Tap:(id)sender {
  [self af_get_json];
}

- (IBAction)btn2Tap:(id)sender {
  [self af_post_json];
}


#pragma mark - < callback >
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
