//
//  DGCPostInfo.h
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGCBaseModel.h"
#import "MDRootDefine.h"
#import "DGCPlaceInfo.h"

@interface DGCPostInfo : DGCBaseModel
PROPERTY_NON_ATOMIC_ASSIGN NSInteger postId;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger site;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger host;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger type_id;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger num_likes;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger num_shared;//该帖子被分享多少次
PROPERTY_NON_ATOMIC_ASSIGN NSInteger num_comments;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger num_posts;//发帖子发帖数
PROPERTY_NON_ATOMIC_ASSIGN NSInteger is_liked;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger is_bookmarked;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger user_id;

PROPERTY_NON_ATOMIC_COPY NSString *user;//等于user.name
PROPERTY_NON_ATOMIC_COPY NSString *emote;
PROPERTY_NON_ATOMIC_COPY NSString *title;
PROPERTY_NON_ATOMIC_COPY NSString *content;
PROPERTY_NON_ATOMIC_COPY NSString *area;
PROPERTY_NON_ATOMIC_COPY NSString *url;

PROPERTY_NON_ATOMIC_COPY NSArray *avatars;
PROPERTY_NON_ATOMIC_COPY NSArray *pictures;

PROPERTY_NON_ATOMIC_COPY NSDate *updated_time;
PROPERTY_NON_ATOMIC_COPY NSDate *created_time;

PROPERTY_NON_ATOMIC_STRONG DGCPlaceInfo *placeInfo;

+(DGCPostInfo *)parsePostInfoByData:(NSDictionary *)data;
@end
