//
//  ShareViewController.m
//  MyShareActionExt
//
//  Created by 冯鸿辉 on 2016/11/3.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
  // Do validation of contentText and/or NSExtensionContext attachments here
  return YES;
}

/**
 *  点击提交按钮
 */
- (void)didSelectPost
{
  [super didSelectPost];
  
  NSLog(@"didSelectPost..");
  
  //加载动画初始化
  UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  activityIndicatorView.frame = CGRectMake((self.view.frame.size.width - activityIndicatorView.frame.size.width) / 2,
                                           (self.view.frame.size.height - activityIndicatorView.frame.size.height) / 2,
                                           activityIndicatorView.frame.size.width,
                                           activityIndicatorView.frame.size.height);
  activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [self.view addSubview:activityIndicatorView];
  
  //激活加载动画
  [activityIndicatorView startAnimating];
  
  __weak ShareViewController *theController = self;
  __block BOOL hasExistsUrl = NO;
  [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
    
    [extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
      
      if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
      {
        [itemProvider loadItemForTypeIdentifier:@"public.url"
                                        options:nil
                              completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                                
                                if ([(NSObject *)item isKindOfClass:[NSURL class]])
                                {
                                  NSLog(@"分享的URL = %@", item);
                                  NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.vimfung.ShareExtensionDemo"];
                                  [userDefaults setValue:((NSURL *)item).absoluteString forKey:@"share-url"];
                                  //用于标记是新的分享
                                  [userDefaults setBool:YES forKey:@"has-new-share"];
                                  
                                  [activityIndicatorView stopAnimating];
                                  [theController.extensionContext completeRequestReturningItems:@[extItem] completionHandler:nil];
                                }
                                
                              }];
        
        hasExistsUrl = YES;
        *stop = YES;
      }
      
    }];
    
    if (hasExistsUrl)
    {
      *stop = YES;
    }
    
  }];
  
  if (!hasExistsUrl)
  {
    //直接退出
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
  }
}

- (NSArray *)configurationItems {
  // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
  return @[];
}

-(void)didSelectCancel{
  
  NSLog(@"didSelectCancel..");
  [super didSelectCancel];
}

@end
