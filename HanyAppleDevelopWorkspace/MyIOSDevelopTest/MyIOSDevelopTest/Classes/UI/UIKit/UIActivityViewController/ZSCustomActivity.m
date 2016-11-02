//
//  ZSCustomActivity.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/2.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "ZSCustomActivity.h"
#import <Social/Social.h>
@implementation ZSCustomActivity

NSString *const UIActivityTypeZSCustomMine = @"ZSCustomActivityMine";

#pragma mark - < overwrite >
//用来标识自定义服务的一个字符串
-(NSString *)activityType{
  
  return UIActivityTypeZSCustomMine;
}

//给用户展示的服务的名称
-(NSString *)activityTitle{
  
  return NSLocalizedString(@"ZS Custom", @"");
}

//给用户展示的服务的图标。关于这里的图标，有非常严格的限制
-(UIImage *)activityImage{

  return [UIImage imageNamed:@"ZS_60x60"];;
}

//指定可以处理的数据类型，如果可以处理则返回YES
-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
  
  NSLog(@"activityItems = %@", activityItems);
  return YES;
}
//在用户选择展示在UIActivityViewController中的自定义服务的图标之后，调用自定义服务处理方法之前的准备工作
-(void)prepareWithActivityItems:(NSArray *)activityItems{

  NSLog(@"Activity prepare = %@", activityItems);
}

//服务类型
+(UIActivityCategory)activityCategory{
  return UIActivityCategoryShare;
}

-(void)performActivity{

  NSLog(@"Activity run");
}

- (void)activityDidFinish:(BOOL)completed{
  
  NSLog(@"Activity finish");
}
@end
