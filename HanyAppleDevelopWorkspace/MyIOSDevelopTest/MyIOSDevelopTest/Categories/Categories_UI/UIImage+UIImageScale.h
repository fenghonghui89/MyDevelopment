//
//  UIImage+UIImageScale.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/8/24.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//切割图片、缩放图片

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;//切割图片
-(UIImage*)scaleToSize:(CGSize)size;//缩放图片
@end
