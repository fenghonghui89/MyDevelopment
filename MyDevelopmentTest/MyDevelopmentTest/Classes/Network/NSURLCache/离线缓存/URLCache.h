//
//  URLCache.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLCache : NSURLCache {
  NSMutableDictionary *cachedResponses;
  NSMutableDictionary *responsesInfo;
}

@property (nonatomic, retain) NSMutableDictionary *cachedResponses;
@property (nonatomic, retain) NSMutableDictionary *responsesInfo;

- (void)saveInfo;

@end