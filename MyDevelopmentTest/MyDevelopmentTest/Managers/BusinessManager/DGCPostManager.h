//
//  DGCPostManager.h
//  TpagesSNS
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DGCListInfo.h"
#import "DGCPostInfo.h"
#import "MDRootDefine.h"


typedef NS_ENUM(NSInteger,DGCPostManagerEditActionType) {
  DGCPostManagerEditActionTypeEdit = 1,
  DGCPostManagerEditActionTypeShare = 2,
  DGCPostManagerEditActionTypeLike = 3,
  DGCPostManagerEditActionTypeUnlike = 4,
  DGCPostManagerEditActionTypeBookmark = 5,
  DGCPostManagerEditActionTypeUnbookmark = 6,
  DGCPostManagerEditActionTypeReport = 7,
  DGCPostManagerEditActionTypeBan = 8,
  
};

#pragma mark - Protocols

@class DGCPostManager;
@protocol  DGCPostManagerDelegate<NSObject>

@optional
/**
 *  接口请求回调函数
 *
 *  @param userServices 当前DGCPostManager对象
 *  @param isSuccess    请求是否成功
 *  @param data         收到的数据
 *  @param code         HTTP状态码
 *  @param msg          接口调用信息
 *  @param userInfo     用户自定义数据
 */
- (void)DGCPosts:(DGCPostManager *)userServices
       isSuccess:(BOOL)isSuccess
            data:(DGCListInfo *)data
       errorCode:(DGCRequestErrorCode)code
             msg:(NSString *)msg
        userInfo:(NSDictionary *)userInfo;

@end


#pragma mark - Interface
@interface DGCPostManager : NSObject


/**
 *  获取接口对象
 *
 *  @return 可用的DGCPostManager对象
 */
+(DGCPostManager *)share;

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
              delegate:(id<DGCPostManagerDelegate>)delegate;


@end
