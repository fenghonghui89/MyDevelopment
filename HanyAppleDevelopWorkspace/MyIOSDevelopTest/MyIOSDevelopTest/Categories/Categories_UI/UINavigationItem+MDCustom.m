//
//  UINavigationItem+MDCustom.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/14.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "UINavigationItem+MDCustom.h"
#import "MDRootDefine.h"
#import <objc/runtime.h>
@implementation UINavigationItem (MDCustom)

#define flag 1 //对应方法1、2、3
#if flag == 1

#elif flag == 2
//方法2
-(UIBarButtonItem *)backBarButtonItem
{
  return [[UIBarButtonItem alloc] initWithTitle:@"方法2" style:UIBarButtonItemStylePlain target:nil action:NULL];
}
#else
//方法3
+(void)load{
  
  DRLog(@"load UINavigationItem+MDCustom..");
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
    Method destMethodImp = class_getInstanceMethod(self, @selector(myCustomBackButton_backBarbuttonItem));
    method_exchangeImplementations(originalMethodImp, destMethodImp);
  });
  
}

static char kCustomBackButtonKey;
-(UIBarButtonItem *)myCustomBackButton_backBarbuttonItem{
  
  DRLog(@"myCustomBackButton_backBarbuttonItem..");
  UIBarButtonItem *item = [self myCustomBackButton_backBarbuttonItem];
  
  if (item) {
    return item;
  }
  
  item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
  if (!item) {
    item = [[UIBarButtonItem alloc] initWithTitle:@"方法3" style:UIBarButtonItemStylePlain target:nil action:NULL];
    objc_setAssociatedObject(self, &kCustomBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  
  return item;
  
}

- (void)dealloc {
  
  objc_removeAssociatedObjects(self);
  
}
#endif
@end
