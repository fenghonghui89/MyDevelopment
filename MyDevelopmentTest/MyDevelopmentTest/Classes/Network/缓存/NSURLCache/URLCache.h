//
//  URLCache.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLCache : NSURLCache

@property (nonatomic, retain) NSMutableDictionary *cachedResponses;//用于保存NSCachedURLResponse
@property (nonatomic, retain) NSMutableDictionary *responsesInfo;//用于保存响应信息的responsesInfo（包括MIME类型和文件名）

- (void)saveInfo;

@end