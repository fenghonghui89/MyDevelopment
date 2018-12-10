//
//  DGCNavigationBarInstance.m
//  tabbar
//
//  Created by 冯鸿辉 on 16/5/9.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "DGCNavigationBarInstance.h"

@interface DGCNavigationBarInstance ()

@end
@implementation DGCNavigationBarInstance

#pragma mark - < view lifecycle > -
-(id)initWithType:(DGCNavigationBarInstanceType)type{

  NSString *xibName = nil;
  switch (type) {
    case DGCNavigationBarInstanceTypeBack:
      xibName = @"DGCNavigationBarInstance";
      break;
      
    default:
      break;
  }
  
  DGCNavigationBarInstance *instance = [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] lastObject];
  return instance;
}

-(instancetype)init{

  return [self initWithType:DGCNavigationBarInstanceTypeBack];
}

-(instancetype)initWithFrame:(CGRect)frame{

  DGCNavigationBarInstance *instance = [[DGCNavigationBarInstance alloc] initWithType:DGCNavigationBarInstanceTypeBack];
  instance.frame = frame;
  return instance;
}

#pragma mark - < actioin > -

- (IBAction)leftButtonTap:(id)sender {
  if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarInstance:leftNavigationBarButtonTap:)]) {
    [self.delegate navigationBarInstance:self leftNavigationBarButtonTap:sender];
  }
}

- (IBAction)rightButtonTap:(id)sender {
  if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarInstance:rightNavigationBarButtonTap:)]) {
    [self.delegate navigationBarInstance:self rightNavigationBarButtonTap:sender];
  }
}
@end
