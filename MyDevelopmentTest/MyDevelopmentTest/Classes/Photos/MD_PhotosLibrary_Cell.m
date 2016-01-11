//
//  MD_PhotosLibrary_Cell.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotosLibrary_Cell.h"

@implementation MD_PhotosLibrary_Cell

- (void)awakeFromNib
{
  [self customInitUI];
  [self customInitData];
}

-(void)customInitUI
{
  self.albumImageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)customInitData
{
  _isTap = NO;
}

-(void)setAlbumImage:(UIImage *)albumImage
{
  _albumImage = albumImage;
  
  [self.albumImageView setImage:albumImage];
}

-(void)setIsTap:(BOOL)isTap
{
  _isTap = isTap;
  if (isTap == YES) {
    [self.selectedImageView setImage:[UIImage imageNamed:@"tickbox_on.png"]];
  }else{
    [self.selectedImageView setImage:[UIImage imageNamed:@"tickbox.png"]];
  }
}

@end
