//
//  UIView+STKit.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/7/7.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "UIView+STKit.h"



@implementation UIView (STKit)


/**
 *  view的vc
 *
 *  @return vc
 */
- (UIViewController *)viewController {
  
  return (UIViewController *)[self nextResponderWithClass:UIViewController.class];
}


/**
 *  递归查找view的nextResponder，直到找到类型为class的Responder
 *
 *  @param class nextResponder的class
 *
 *  @return 第一个满足类型为class的UIResponder
 */
- (UIResponder *)nextResponderWithClass:(Class)class {
  
  UIResponder *nextResponder = self;
  
  while (nextResponder) {
    nextResponder = nextResponder.nextResponder;
    if ([nextResponder isKindOfClass:class]) {
      return nextResponder;
    }
  }
  return nil;
}

/**
 *  查找firstResponder
 *
 *  @return firstResponder
 */
- (UIResponder *)findFirstResponder {
  
  if (self.isFirstResponder) {
    return self;
  }
  
  for (UIView *subView in self.subviews) {
    id responder = [subView findFirstResponder];
    if (responder) {
      return responder;
    }
  }
  
  return nil;
}

@end
