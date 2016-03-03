//
//  MD_PhotoLibrary_PreviewVC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotoLibrary_PreviewVC.h"

@interface MD_PhotoLibrary_PreviewVC ()<PHPhotoLibraryChangeObserver>


@end

@implementation MD_PhotoLibrary_PreviewVC

#pragma mark - < vc lifecycle > -

-(void)dealloc{
//  [self removeObserver];
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self addObserver];
  [self customInitUI];
}

#pragma mark - < method > -
#pragma mark noti & observer
-(void)addObserver{
  [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

-(void)removeObserver{
  [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

#pragma mark customInit
-(void)customInitUI{
  // Prepare the options to pass when fetching the live photo.
  PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
  options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
  options.networkAccessAllowed = YES;
  options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {

  };
  
  [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:[self targetSize] contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
    
    // Check if the request was successful.
    if (!result) {
      return;
    }
    
    // Show the UIImageView and use it to display the requested image.
    self.imageView.image = result;
  }];

}

-(CGSize)targetSize{
  CGFloat scale = [UIScreen mainScreen].scale;
  CGSize targetSize = CGSizeMake(CGRectGetWidth(self.imageView.bounds) * scale, CGRectGetHeight(self.imageView.bounds) * scale);
  return targetSize;
}

#pragma mark - < action > -
#pragma mark - < callback > -

@end
