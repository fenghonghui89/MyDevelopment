//
//  DGCUserInfo.h
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import "DGCBaseModel.h"

@interface DGCUserInfo : DGCBaseModel
@property (nonatomic,assign)NSInteger userId;
@property (nonatomic,copy)NSString * userName;
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * token;

@property (nonatomic,strong)NSArray *typeList;
@end
