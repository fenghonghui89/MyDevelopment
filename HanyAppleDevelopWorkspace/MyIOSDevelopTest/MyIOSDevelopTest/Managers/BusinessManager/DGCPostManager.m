//
//  DGCPostManager.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCPostManager.h"
#import "MDTool.h"
#import "DGCDelegateInfo.h"
#import "DGCServerCallBackDelegate.h"
#import "DGCPostServices.h"


#pragma mark - Catalogue
@interface DGCPostManager()<DGCServerCallBackDelegate>
@end


#pragma mark - Implementation
@implementation DGCPostManager


+(DGCPostManager *)share
{
  static DGCPostManager *share = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    share = [[self alloc] init];
  });
  return share;
}


/**
 *  最近更新帖子列表
 *
 *  @param since        从哪张帖子之后的帖子
 *  @param before       从哪张帖子之前的帖子
 *  @param per_page     返回几条记录，默认为`5`
 *  @param site         可选，帖子所在站点ID，默认为当前站点
 *  @param host         可选，帖子所属主体ID
 *  @param type         可选，帖子所属类型ID
 *  @param user         可选，发帖人用户ID
 *  @param userinfo     自定义信息
 *  @param delegate     代理
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
              delegate:(id<DGCPostManagerDelegate>)delegate
{
  DGCDelegateInfo *delegateInfo = [[DGCDelegateInfo alloc] init];
  delegateInfo.delegate = delegate;
  delegateInfo.code = DGCRequestCodePost;
  delegateInfo.info = userinfo;
  
  [[DGCPostServices share] getPostsBySince:since
                                    before:before
                                  per_page:per_page
                                      site:site
                                  location:location
                                     place:place
                                      type:type
                                      user:user
                                  userinfo:[NSDictionary dictionaryWithObject:delegateInfo forKey:DGC_DELEGATE_INFO_KEY]
                                  delegate:self];
}



#pragma mark - net callback
-(void)DGCServicesSuccess:(DGCBaseModel *)data
                errorCode:(DGCRequestErrorCode)code
                      msg:(NSString *)msg
                 userInfo:(NSDictionary *)userInfo
{
  DGCDelegateInfo *delegateInfo = [userInfo objectForKey:DGC_DELEGATE_INFO_KEY];
  id delegate = delegateInfo.delegate;
  
  switch (delegateInfo.code) {
    case DGCRequestCodePost:
      [self callBackByPosts:delegate
                  isSuccess:YES
                       data:(DGCListInfo *)data
                  errorCode:DGCRequestErrorCodeSuccess
                        msg:msg
                   userInfo:delegateInfo.info];
      break;
        default:
      break;
  }
  
}

-(void)DGCServicesFailer:(DGCBaseModel *)data
               errorCode:(DGCRequestErrorCode)code
                     msg:(NSString *)msg
                userInfo:(NSDictionary *)userInfo
{
  DGCDelegateInfo *delegateInfo = [userInfo objectForKey:DGC_DELEGATE_INFO_KEY];
  id delegate = delegateInfo.delegate;
  switch (delegateInfo.code) {
    case DGCRequestCodePost:
      [self callBackByPosts:delegate
                  isSuccess:NO
                       data:(DGCListInfo *)data
                  errorCode:code
                        msg:msg
                   userInfo:delegateInfo.info];
      break;
        default:
      break;
  }
  
}



#pragma mark - callback
- (void)callBackByPosts:(id)delegate
              isSuccess:(BOOL)isSuccess
                   data:(DGCListInfo *)data
              errorCode:(DGCRequestErrorCode)code
                    msg:(NSString *)msg
               userInfo:(NSDictionary *)userInfo
{
  if ([MDTool cureentThreadIsMain]) {
    if ([delegate respondsToSelector:@selector(DGCPosts:isSuccess:data:errorCode:msg:userInfo:)]) {
      [delegate DGCPosts:self isSuccess:isSuccess data:data errorCode:code msg:msg userInfo:userInfo];
    }
  }else{
    dispatch_async(dispatch_get_main_queue(), ^{
      if ([delegate respondsToSelector:@selector(DGCPosts:isSuccess:data:errorCode:msg:userInfo:)]) {
        [delegate DGCPosts:self isSuccess:isSuccess data:data errorCode:code msg:msg userInfo:userInfo];
      }
    });
  }
}

@end
