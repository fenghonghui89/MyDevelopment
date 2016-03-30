//
//  DGCPostInfo.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCPostInfo.h"
#import "DGCDataParser.h"
#import "NSDate+Tpages.h"
@implementation DGCPostInfo


+(DGCPostInfo *)parsePostInfoByData:(NSDictionary *)data
{
  DGCPostInfo *postInfo = [DGCPostInfo new];
  
  postInfo.postId = [DGCDataParser parseIntData:data key:@"id"];
  postInfo.site = [DGCDataParser parseIntData:data key:@"site"];
  postInfo.host = [DGCDataParser parseIntData:data key:@"host"];
  postInfo.type_id = [DGCDataParser parseIntData:data key:@"type_id"];
  postInfo.num_likes = [DGCDataParser parseIntData:data key:@"num_likes"];
  postInfo.num_shared = [DGCDataParser parseIntData:data key:@"num_shared"];
  postInfo.num_comments = [DGCDataParser parseIntData:data key:@"num_comments"];
  postInfo.num_posts = [DGCDataParser parseIntData:data key:@"num_posts"];
  postInfo.is_liked = [DGCDataParser parseIntData:data key:@"is_liked"];
  postInfo.is_bookmarked = [DGCDataParser parseIntData:data key:@"is_bookmarked"];
  postInfo.user_id = [DGCDataParser parseIntData:data key:@"user_id"];
  
  postInfo.user = [DGCDataParser parseStrData:data key:@"user"];
  postInfo.emote = [DGCDataParser parseStrData:data key:@"emote"];
  postInfo.title = [DGCDataParser parseStrData:data key:@"title"];
  postInfo.content = [DGCDataParser parseStrData:data key:@"content"];
  postInfo.area = [DGCDataParser parseStrData:data key:@"area"];
  postInfo.url = [DGCDataParser parseStrData:data key:@"url"];
  
  postInfo.avatars = [DGCDataParser parseArrayData:data key:@"avatars"];
  postInfo.pictures = [DGCDataParser parseArrayData:data key:@"pictures"];
  
  postInfo.updated_time = [NSDate fromServerDateTimeString:[data objectForKey:@"updated_time"]];
  postInfo.created_time = [NSDate fromServerDateTimeString:[data objectForKey:@"created_time"]];
  
  
  if ([data objectForKey:@"place"]) {
    DGCPlaceInfo *placeInfo = [DGCPlaceInfo parsePlaceInfoByData:[data objectForKey:@"place"]];
    postInfo.placeInfo = placeInfo;
  }

  return postInfo;
}
@end
