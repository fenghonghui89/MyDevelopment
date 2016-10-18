//
//  DGCListModel.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/10/27.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "DGCListInfo.h"

@implementation DGCListInfo
- (void)encodeWithCoder:(NSCoder *)aCoder{
  [aCoder encodeObject:_places forKey:@"places"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super init];
  if (self) {
    self.places = [aDecoder decodeObjectForKey:@"place"];
  }
  return self;
}

@end
