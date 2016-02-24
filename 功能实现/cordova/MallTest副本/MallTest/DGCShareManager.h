//
//  DGCShareManager.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/2/15.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DGCShareManager;
@protocol DGCShareManagerDelegate <NSObject>

@optional
-(void)shareManager:(DGCShareManager *)shareManager shareDidFinish:(BOOL)result;

@end
@interface DGCShareManager : NSObject


+(DGCShareManager *)shareInstance;
-(void)startUMShare;
-(BOOL)handleOpenURL:(NSURL *)url;
-(void)share:(UIViewController *)viewController
    delegate:(id<DGCShareManagerDelegate>)delegate
       title:(NSString *)title
   shareText:(NSString *)shareText
         url:(NSString *)urlstring
      imgUrl:(NSString *)imgUrlString;

-(void)wechatLogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block;
-(void)qqlogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block;
-(void)weiboLogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block;


@end
