//
//  UMShareManager.h
//  umengtest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

typedef NS_ENUM(NSInteger,LoginType){
    LoginTypeWeChat = 0,
    LoginTypeWeibo = 1,
    LoginTypeQQ = 2
};
@interface UMShareManager : NSObject
+(UMShareManager *)share;
-(void)startUMShare;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

-(void)wechatLogin:(UIViewController *)viewController;
-(void)weiboLogin:(UIViewController *)viewController;
-(void)qqlogin:(UIViewController *)viewController;
-(void)share:(UIViewController *)viewController
   shareText:(NSString *)shareText
  shareImage:(UIImage *)shareImage;
-(void)logout:(LoginType)loginType;

-(void)share:(UIViewController *)viewController
       title:(NSString *)title
   shareText:(NSString *)shareText
  shareImage:(UIImage *)shareImage
         url:(NSString *)urlstring;

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType controller:(UIViewController *)controller;
@end
