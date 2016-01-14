//
//  Weibo.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboUserInfo.h"

@interface Weibo : NSObject
@property(nonatomic,retain)NSString *created_at;//创建时间
@property(nonatomic,retain)NSString *source;//微博来源
@property(nonatomic,retain)NSString *text;//微博内容
@property(nonatomic,retain)NSArray *pic_urls;//微博配图
@property(nonatomic,retain)NSNumber *reposts_count;//转发数
@property(nonatomic,retain)NSNumber *comments_count;//评论数
@property(nonatomic,retain)Weibo *retweeted_status;//被转发的微博
@property(nonatomic,retain)WeiboUserInfo *weiboUserInfo;//用户信息

@property(nonatomic,assign)BOOL isRetweeted;
-(float)getWeiboCellHeight;//计算cell所占高度
@end
