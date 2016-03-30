//
//  AFNetworkManager.m
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworkManager.h"
#import "NSString+Category.h"
#import "AFNetworking.h"
#import "MDTool.h"
#import "DGCUserInfo.h"
#import "DGCServerCallBackDelegate.h"
#import "DGCListInfo.h"
#import "DGCPostInfo.h"


#define DGC_FULLURL_INFO_KEY @"fullurl"
#define HTTP_REQUEST    1
#define JSON_REQUEST    2
#define BINARY_REQUEST  3

#define SORT_DEFAULT    0
#define SORT_TEXT       1

#define LOGIN_USERNAME  1
#define LOGIN_EMAIL     2
#define LOGIN_MOBILE    3
#define LOGIN_NAME      4
#define LOGIN_MD5       (1 << 16)

@interface AFNetworkManager()

@end
@implementation AFNetworkManager

#pragma mark - < units > -
+(AFNetworkManager *)share
{
  static AFNetworkManager *share = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    share = [[self alloc] init];
    [share startNetworkReachability];
  });
  return share;
}

-(AFHTTPRequestOperationManager*)setupManagerFor:(NSInteger)requestType userinfo:(NSDictionary *)userinfo{
  AFHTTPRequestOperationManager *manager;
  
  //是否包含BaseURL
  if(YES == [(NSNumber*)[userinfo objectForKey:DGC_FULLURL_INFO_KEY] boolValue])
    manager = [[AFHTTPRequestOperationManager alloc] init];
  else
    manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:DGCBaseURL]];
  
  if(JSON_REQUEST == requestType){//json
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
  }else if(BINARY_REQUEST == requestType){//binary
    
  }else{//http
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  }
  
  
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  manager.requestSerializer.timeoutInterval = 20;
  [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  manager.securityPolicy.allowInvalidCertificates = true;
  
  return manager;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
  if (jsonString == nil) {
    return nil;
  }
  
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *err;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
  if(err) {
    DLog(@"json解析失败：%@",err);
    return nil;
  }
  return dic;
}

-(void)failureCallback:(DGCServiceFailedBlock)failerBlock
              userinfo:(NSDictionary *)userinfo
             operation:(AFHTTPRequestOperation *)operation
                 error:(NSError *)error
{
  
  NSError *finalError;
  
  NSHTTPURLResponse *resp = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
  NSInteger statusCode = [resp statusCode];
  
  NSString *msg;
  if(nil == finalError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]){
    msg = finalError.localizedDescription;
  }else{
    msg = [[NSString alloc] initWithData:finalError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
  }
  NSDictionary *dic = [self dictionaryWithJsonString:msg];
  NSString *message = [dic objectForKey:@"message"];
  
  switch (statusCode) {
    case 500:
    {
      if ([message isBlankString]) {//服务器返回500
        finalError = error;
      }else{//afnetwork返回500
        NSHTTPURLResponse *errorResponse = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] statusCode:1000 HTTPVersion:nil headerFields:nil];
        NSString *msg = [NSString stringWithFormat:@"{\"message\":\"%@\"}",NSLocalizedString(@"NetworkWrongMsg", nil)];
        NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *errorUserInfo = @{AFNetworkingOperationFailingURLResponseErrorKey:errorResponse,AFNetworkingOperationFailingURLResponseDataErrorKey:data};
        NSError *customError = [[NSError alloc] initWithDomain:@"customError.com" code:1000 userInfo:errorUserInfo];
        finalError = customError;
      }
    }
      break;
    case 0:
    {
      NSHTTPURLResponse *errorResponse = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] statusCode:1000 HTTPVersion:nil headerFields:nil];
      NSString *msg = [NSString stringWithFormat:@"{\"message\":\"%@\"}",NSLocalizedString(@"NetworkWrongMsg", nil)];
      NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *errorUserInfo = @{AFNetworkingOperationFailingURLResponseErrorKey:errorResponse,AFNetworkingOperationFailingURLResponseDataErrorKey:data};
      NSError *customError = [[NSError alloc] initWithDomain:@"customError.com" code:1000 userInfo:errorUserInfo];
      finalError = customError;
    }
      break;
    case 422:
    {
      NSHTTPURLResponse *errorResponse = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] statusCode:1000 HTTPVersion:nil headerFields:nil];
      NSString *msg = [NSString stringWithFormat:@"{\"message\":\"%@\"}",NSLocalizedString(@"Parameters error", nil)];
      NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *errorUserInfo = @{AFNetworkingOperationFailingURLResponseErrorKey:errorResponse,AFNetworkingOperationFailingURLResponseDataErrorKey:data};
      NSError *customError = [[NSError alloc] initWithDomain:@"customError.com" code:1422 userInfo:errorUserInfo];
      finalError = customError;
    }
      break;
    default:
    {
      finalError = error;
    }
      break;
  }
  
  
  resp = finalError.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
  if(nil == finalError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]){
    msg = finalError.localizedDescription;
  }else{
    msg = [[NSString alloc] initWithData:finalError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
  }
  
  statusCode = [resp statusCode];
  dic = [self dictionaryWithJsonString:msg];
  message = [dic objectForKey:@"message"];
  NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:userinfo];
  [info setValue:operation forKey:@"operation"];
  [info setValue:finalError forKey:@"error"];
  failerBlock(statusCode, message, userinfo);
}


-(void)startNetworkReachability
{
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    DLog(@"me - network change status:%ld",(long)status);
  }];
  [manager startMonitoring];
}

#pragma mark - < method > -
/**
 *  将数组中的数据载入到帖子模型列表
 *
 *  @param array 要载入的数组
 *
 *  @return DGCListInfo*
 */
-(DGCListInfo*)loadPostListFromArray:(NSArray*)array
{
  if(nil == array)
    return nil;
  
  NSMutableArray *newArray = [NSMutableArray array];
  for(NSDictionary *dic in array)
    [newArray addObject:[DGCPostInfo parsePostInfoByData:dic]];
  
  DGCListInfo *listInfo = [DGCListInfo new];
  listInfo.items = [NSArray arrayWithArray:newArray];
  
  return listInfo;
}
#pragma mark - < interfaces > -
/**
 *  1.登录
 *
 *  @param username     用户名
 *  @param password     密码
 *  @param sysmodel     系统类型
 *  @param deviceId     设备id
 *  @param userinfo     自定义信息
 *  @param successBlock 成功回调
 *  @param failerBlock  失败回调
 */
-(void)loginByUsername:(NSString *)username
              password:(NSString *)password
              sysmodel:(NSInteger)sysmodel
              userinfo:(NSDictionary *)userinfo
       successCallBack:(DGCServiceSuccessBlock)successBlock
        failerCallBack:(DGCServiceFailedBlock)failerBlock;
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  NSString *requestURL = @"http://51uca.com/biz/login";
  NSString *md5_password = [MDTool md5:password];
  NSString *md5_tmp = [md5_password stringByAppendingString:@"rickyhoxiaoyi@163.com"];
  NSString *md5_final = [MDTool md5:md5_tmp];
  
  NSDictionary *paraDic = @{@"username":username,
                            @"password":md5_final,
                            @"sysModel":@(sysmodel),
                            };
  
  [manager POST:requestURL parameters:paraDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    NSInteger errorCode = [[dic objectForKey:@"status"] integerValue];
    
    if (errorCode == DGCRequestErrorCodeSuccess) {
      NSDictionary * infoDict = [dic objectForKey:@"data"];
      DGCUserInfo * uf = nil;
      if(infoDict){
        //创建实体
        uf = [DGCUserInfo new];
        
        //typeList
        id typeList = [infoDict objectForKey:@"typeList"];
        if ([typeList isKindOfClass:[NSArray class]]) {
          if (((NSArray *)typeList).count > 0) {
            uf.typeList = (NSArray *)typeList;
          }
        }
        
        //loginAccount
        NSDictionary *loginAccountDic = [infoDict objectForKey:@"loginAccount"];
        uf.userId = [[loginAccountDic objectForKey:@"userId"] integerValue];
        uf.userName = [loginAccountDic objectForKey:@"userName"];
        uf.icon = [loginAccountDic objectForKey:@"icon"];
        uf.token = [loginAccountDic objectForKey:@"token"];
      }
      
      successBlock(uf,userinfo);
    }else{
      NSString *msg = [dic objectForKey:@"errMsg"];
      failerBlock(errorCode,msg,userinfo);
    }
  } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    failerBlock(-100,@"网络错误",userinfo);
  }];
}

/**
 *  最近更新帖子列表
 *
 *  @param since        从哪张帖子之后的帖子
 *  @param before       从哪张帖子之前的帖子
 *  @param per_page     返回几条记录，默认为`5`
 *  @param site         可选，帖子所在站点ID，默认为当前站点(暂时用不上)
 *  @param host         可选，帖子所属主体ID
 *  @param type         可选，帖子所属类型ID
 *  @param user         可选，发帖人用户ID
 *  @param userinfo     自定义信息
 *  @param successBlock 成功回调
 *  @param failerBlock  失败回调
 */
-(void)getPostsBySince:(NSInteger)since
                before:(NSInteger)before
              per_page:(NSInteger)per_page
                  site:(NSInteger)site
              location:(NSInteger)location
                 place:(NSInteger)place
                  type:(NSInteger)type
                  user:(NSInteger)user
              userinfo:(NSDictionary *)userinfo
       successCallBack:(DGCServiceSuccessBlock)successBlock
        failerCallBack:(DGCServiceFailedBlock)failerBlock
{
  NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
  if (since != 0) {
    [paramDic setObject:@(since) forKey:@"since"];
  }
  if (before != 0) {
    [paramDic setObject:@(before) forKey:@"before"];
  }
  if (location != 0) {
    [paramDic setObject:@(location) forKey:@"location"];
  }
  if (type != 0) {
    [paramDic setObject:@(type) forKey:@"type"];
  }
  if (per_page != 0) {
    [paramDic setObject:@(per_page) forKey:@"per_page"];
  }
  if (user != 0) {
    [paramDic setObject:@(user) forKey:@"user"];
  }
  if (place != 0) {
    [paramDic setObject:@(place) forKey:@"place"];
  }
  
  DLog(@"最近更新帖子列表 paramDic %@",paramDic);
  
  AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:DGCBaseURL]];
  
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  manager.requestSerializer.timeoutInterval = 20;
  [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  
  manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  manager.securityPolicy.allowInvalidCertificates = true;
  
  [manager GET:@"/posts"
    parameters:paramDic
       success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         DLog(@"最近更新帖子列表成功 %@",responseObject);
         successBlock([self loadPostListFromArray:responseObject], userinfo);
       }
       failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         DLog(@"最近更新帖子列表失败 %@",error);
         [self failureCallback:failerBlock userinfo:userinfo operation:operation error:error];
       }];
  
}

@end
