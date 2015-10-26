//
//  UMShareManager.h
//  umengtest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginType){
    LoginTypeWeChat = 0,
    LoginTypeWeibo = 1,
    LoginTypeQQ = 2
};
@interface UMShareManager : NSObject
+(UMShareManager *)share;
-(void)startUMShare;
-(BOOL)handleOpenURL:(NSURL *)url;
-(void)wechatLogin:(UIViewController *)viewController;
-(void)weiboLogin:(UIViewController *)viewController;
-(void)qqlogin:(UIViewController *)viewController;
-(void)share:(UIViewController *)viewController
   shareText:(NSString *)shareText
  shareImage:(UIImage *)shareImage;
-(void)logout:(LoginType)loginType;

@end
