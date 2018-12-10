//
//  DGCTabBarItem.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCTabBarItem.h"

@interface DGCTabBarItem()

@end
@implementation DGCTabBarItem

- (id)initWithImage:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
                tag:(NSInteger)tag{

  NSAssert(image, @"DGCTabBarItem - > image not be nil");
  NSAssert(image, @"DGCTabBarItem - > selectedImage not be nil");
  
  self = [super init];
  if (self) {
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    self.tag = tag;
  }
  return self;
}

@end
