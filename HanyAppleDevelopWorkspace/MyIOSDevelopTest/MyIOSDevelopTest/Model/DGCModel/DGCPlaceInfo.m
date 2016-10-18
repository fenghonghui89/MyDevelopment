//
//  DGCPlaceInfo.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/11/19.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCPlaceInfo.h"
#import "DGCDataParser.h"
@implementation DGCPlaceInfo

+(DGCPlaceInfo *)parsePlaceInfoByData:(NSDictionary *)data
{
  DGCPlaceInfo *placeInfo = [DGCPlaceInfo new];
  
  placeInfo.placeId = [DGCDataParser parseIntData:data key:@"id"];
  placeInfo.v2id = [DGCDataParser parseIntData:data key:@"v2id"];
  placeInfo.host = [DGCDataParser parseIntData:data key:@"host"];
  placeInfo.type = [DGCDataParser parseIntData:data key:@"type"];
  
  placeInfo.name = [DGCDataParser parseStrData:data key:@"name"];
  placeInfo.summary = [DGCDataParser parseStrData:data key:@"summary"];
  placeInfo.address = [DGCDataParser parseStrData:data key:@"address"];
  placeInfo.coord = [DGCDataParser parseStrData:data key:@"coord"];
  placeInfo.longitude = [DGCDataParser parseStrData:data key:@"longitude"];
  placeInfo.latitude = [DGCDataParser parseStrData:data key:@"latitude"];
  placeInfo.remark = [DGCDataParser parseStrData:data key:@"remark"];
  placeInfo.average_cost = [DGCDataParser parseStrData:data key:@"average_cost"];
  placeInfo.tel_num = [DGCDataParser parseStrData:data key:@"tel_num"];
  placeInfo.business_hour = [DGCDataParser parseStrData:data key:@"business_hour"];
  
  placeInfo.pictures = [DGCDataParser parseArrayData:data key:@"pictures"];
  
  return placeInfo;
}
@end
