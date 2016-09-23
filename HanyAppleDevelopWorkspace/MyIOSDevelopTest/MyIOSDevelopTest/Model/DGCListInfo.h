//
//  DGCListModel.h
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCBaseModel.h"
#import "MDRootDefine.h"
@interface DGCListInfo : DGCBaseModel<NSCoding>

PROPERTY_NON_ATOMIC_STRONG NSArray *items;
PROPERTY_NON_ATOMIC_STRONG NSArray *errors;
PROPERTY_NON_ATOMIC_STRONG NSArray *friends;
PROPERTY_NON_ATOMIC_STRONG NSArray *requests;
PROPERTY_NON_ATOMIC_STRONG NSArray *comments;
PROPERTY_NON_ATOMIC_STRONG NSArray *recieveds;
PROPERTY_NON_ATOMIC_STRONG NSArray *sents;
PROPERTY_NON_ATOMIC_STRONG NSArray *places;
PROPERTY_NON_ATOMIC_STRONG NSArray *users;
PROPERTY_NON_ATOMIC_STRONG NSArray *posts;

PROPERTY_NON_ATOMIC_ASSIGN NSInteger total;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger per_page;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger current_page;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger last_page;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger from;
PROPERTY_NON_ATOMIC_ASSIGN NSInteger to;

PROPERTY_NON_ATOMIC_STRONG NSString *message;
PROPERTY_NON_ATOMIC_COPY NSString *next_page_url;
PROPERTY_NON_ATOMIC_COPY NSString *prev_page_url;
@end
