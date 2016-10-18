//
//  MD_Model1.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Model1.h"

#import "ImageDownloader.h"

@implementation MDBag

@end

@implementation MDStudent

@end



@implementation MDImageItem

-(id)initWithDic:(NSDictionary *)dic{
  self = [super init];
  if (self) {
    self.imageName = [dic objectForKey:@"imageName"];
    self.imageUrl = [dic objectForKey:@"imageUrl"];
    self.image = [[ImageDownloader shareImageDownloader] loadLocalImage:self.imageUrl];
  }
  return self;
}

+(NSMutableArray *)handleData:(NSData *)data{
  NSError *error = nil;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
  NSArray *originalArray = [dic objectForKey:@"images"];
  
  NSMutableArray *resultArray = [NSMutableArray array];
  for (NSDictionary *dic in originalArray) {
    MDImageItem *imageItem = [[MDImageItem alloc] initWithDic:dic];
    [resultArray addObject:imageItem];
  }
  
  return resultArray;
}

@end
