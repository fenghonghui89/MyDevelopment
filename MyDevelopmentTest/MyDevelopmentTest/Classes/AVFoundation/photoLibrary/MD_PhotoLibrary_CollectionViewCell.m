//
//  MD_PhotoLibrary_CollectionViewCell.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotoLibrary_CollectionViewCell.h"
@interface MD_PhotoLibrary_CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *livePhotoBadgeImageView;
@end
@implementation MD_PhotoLibrary_CollectionViewCell

- (void)prepareForReuse {
  [super prepareForReuse];
  self.imageView.image = nil;
  self.livePhotoBadgeImageView.image = nil;
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
  _thumbnailImage = thumbnailImage;
  self.imageView.image = thumbnailImage;
}

- (void)setLivePhotoBadgeImage:(UIImage *)livePhotoBadgeImage {
  _livePhotoBadgeImage = livePhotoBadgeImage;
  self.livePhotoBadgeImageView.image = livePhotoBadgeImage;
}

@end
