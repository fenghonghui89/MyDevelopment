//
//  ImageDownloader.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+(ImageDownloader *)shareImageDownloader{
  static ImageDownloader *shareImageDownloader = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    shareImageDownloader = [[self alloc] init];
  });
  
  return shareImageDownloader;
}

-(void)startDownloadImage:(NSString *)imageUrl complationHandle:(void(^)(UIImage *image))complationHandle{

  UIImage *localImage = [self loadLocalImage:imageUrl];
  
  if (localImage == nil) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
      NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
      [imageData writeToFile:[self imageFilePath:imageUrl] atomically:YES];
      
      dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageWithData:imageData];
        if (complationHandle) {
          complationHandle(image);
        }
      });
    });
  }else{
    if (complationHandle) {
      complationHandle(localImage);
    }
  }
}

-(UIImage *)loadLocalImage:(NSString *)imageUrl{
  
  NSString *iamgePath = [self imageFilePath:imageUrl];
  UIImage *image = [UIImage imageWithContentsOfFile:iamgePath];
  
  if (image != nil) {
    return image;
  }
  
  return nil;
}

-(NSString *)imageFilePath:(NSString *)imageUrl{
  
  //获取cache路径
  NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  
  //创建Download文件夹
  NSString *downloadImagesPath = [cachePath stringByAppendingString:@"/DownloadImages"];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath:downloadImagesPath]) {
    [fileManager createDirectoryAtPath:downloadImagesPath withIntermediateDirectories:YES attributes:nil error:nil];
  }
  
  NSString *imageName = [imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
  NSString *imagePath = [downloadImagesPath stringByAppendingPathComponent:imageName];
  
  return imagePath;
}
@end
