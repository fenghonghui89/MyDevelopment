//
//  UIView+STKit.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/7/7.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (STKit)

/**
 *  view的vc
 *
 *  @return vc
 */
- (UIViewController *)viewController;

/**
 *  递归查找view的nextResponder，直到找到类型为class的Responder
 *
 *  @param class nextResponder的class
 *
 *  @return 第一个满足类型为class的UIResponder
 */
- (UIResponder *)nextResponderWithClass:(Class) class;

/**
 *  查找firstResponder
 *
 *  @return firstResponder
 */
- (UIResponder *)findFirstResponder;

@end
