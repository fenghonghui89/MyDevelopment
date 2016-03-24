//
//  ImageDownloader.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageDownloader : NSObject
+(ImageDownloader *)shareImageDownloader;
-(void)startDownloadImage:(NSString *)imageUrl complationHandle:(void(^)(UIImage *image))complationHandle;
-(UIImage *)loadLocalImage:(NSString *)imageUrl;
@end
