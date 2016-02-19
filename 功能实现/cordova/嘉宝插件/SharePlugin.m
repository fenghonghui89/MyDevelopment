//
//  SharePlugin.m
//  JetsunListen
//
//  Created by Pizza on 15/10/21.
//  Copyright © 2015年 jetsun. All rights reserved.
//

#import "SharePlugin.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "AFAppDotNetAPIClient.h"
#import "NSURL+QueryDictionary.h"

@implementation SharePlugin
- (void)shareAction:(CDVInvokedUrlCommand *)command {
    WeakSelf(weakSelf);
    NSString *title = command.arguments[0];
    NSString *imageUrl = command.arguments[1];
    NSString *shareUrl = command.arguments[2];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSDictionary *params = AFAppGetUserCerDict();
    NSURL *url = [[NSURL URLWithString:shareUrl] uq_URLByAppendingQueryDictionary:params];
    
    [shareParams SSDKSetupShareParamsByText:title
                                     images:@[imageUrl]
                                        url:url
                                      title:@"菠萝球迷圈"
                                       type:SSDKContentTypeAuto];
    
    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //2、分享
    [ShareSDK showShareActionSheet:self.viewController.view
                             items:activePlatforms
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           [UtilityTool showLoadingHubInView:weakSelf.viewController.view];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           [UtilityTool hideHUDInView:weakSelf.viewController.view];
                           [UtilityTool showHUDInView:weakSelf.viewController.view WithType:MBProgressHUDModeText AndMsg:@"分享成功" time:2.0f autoHidden:YES];
                           [[BoloPreference sharePreference] activityAddWithType:ActivityAddTypeShare];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           [UtilityTool hideHUDInView:weakSelf.viewController.view];
                           [UtilityTool showHUDInView:weakSelf.viewController.view WithType:MBProgressHUDModeText AndMsg:@"分享失败" time:2.0f  autoHidden:YES];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           [UtilityTool hideHUDInView:weakSelf.viewController.view];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}
@end
