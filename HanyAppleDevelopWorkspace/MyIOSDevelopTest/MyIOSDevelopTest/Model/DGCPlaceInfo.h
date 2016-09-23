//
//  DGCPlaceInfo.h
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/11/19.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCBaseModel.h"

@interface DGCPlaceInfo : DGCBaseModel
@property(nonatomic,assign)NSInteger placeId;
@property(nonatomic,assign)NSInteger v2id;
@property(nonatomic,assign)NSInteger host;
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *coord;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *average_cost;
@property(nonatomic,copy)NSString *tel_num;
@property(nonatomic,copy)NSString *business_hour;

@property(nonatomic,copy)NSArray *pictures;

+(DGCPlaceInfo *)parsePlaceInfoByData:(NSDictionary *)data;
@end
