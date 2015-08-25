//
//  UIImage+UIImageScale.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/8/24.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
@end
