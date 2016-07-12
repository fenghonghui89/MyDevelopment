//
//  DGCPushManager.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/11.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCPushManager: NSObject,UMSocialUIDelegate {
  
  
  var vc:UIViewController?
  
  
  static let sharedInstance:DGCPushManager = {
  
    let instance = DGCPushManager()
    return instance
  }()
  
  
  func startUMShare() {
    
    //设置友盟社会化组件appkey
    UMSocialData.setAppKey(UMENG_APPKEY)
    
    //打开调试log的开关
    UMSocialData.openLog(true)
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    UMSocialWechatHandler.setWXAppId(UMENG_WECHAT_APPID, appSecret: UMENG_WECHAT_APPSECRET, url: UMENG_WECHAT_URL)
    
    //新浪微博
    UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(UMENG_WEIBO_APPKEY, secret: UMENG_WEIBO_SECRET, redirectURL: UMENG_WEIBO_URL)
    
    //QQ登录只支持SSO登录方式，必须具备手机QQ客户端，Qzone默认调用SSO登录
    UMSocialQQHandler.setQQWithAppId(UMENG_QQ_APPID, appKey: UMENG_QQ_APPKEY, url: UMENG_QQ_URL)
  }
  
  
  func handleOpenURL(url:NSURL) -> Bool {
    return UMSocialSnsService.handleOpenURL(url)
  }
  
  //MARK:action
  func share(viewController:UIViewController,title:String,shareText:String,url urlString:String,imgUrl imgUrlString:String) {
    
    self.vc = viewController
    
    UMSocialData.defaultData().extConfig.wechatSessionData.url = urlString
    UMSocialData.defaultData().extConfig.wechatTimelineData.url = urlString
    UMSocialData.defaultData().extConfig.qqData.url = urlString
    UMSocialData.defaultData().extConfig.qzoneData.url = urlString
    
    UMSocialData.defaultData().extConfig.qqData.title = title
    UMSocialData.defaultData().extConfig.qzoneData.title = title
    UMSocialData.defaultData().extConfig.wechatSessionData.title = title
    UMSocialData.defaultData().extConfig.wechatTimelineData.title = title
    
    UMSocialData.defaultData().urlResource.setResourceType(UMSocialUrlResourceTypeImage, url: imgUrlString)
    
    //如果没有装客户端则隐藏
    UMSocialConfig.hiddenNotInstallPlatforms([UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina])
    
    //qq
    UMSocialQQHandler.setQQWithAppId(UMENG_QQ_APPID, appKey: UMENG_QQ_APPKEY, url: urlString)
    
    //sheetview形式
    UMSocialSnsService.presentSnsController(viewController,
                                            appKey: UMENG_APPKEY,
                                            shareText: shareText,
                                            shareImage: nil,
                                            shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone],
                                            delegate: self)
  }
  
  
  
  
  /*
   -(void)wechatLogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block
   */
  
  func wechatLogin(viewController:UIViewController,block:(paramDic:NSDictionary)->Void) {
    
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//    
//    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//      DLog(@"微信返回的responseCode:%d",response.responseCode);
//      if (response.responseCode == UMSResponseCodeSuccess) {
//        UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
//        NSString *expirationDate = [formatter stringFromDate:snsAccount.expirationDate];
//        DRLog(@"微信登录成功platformName:%@ ,openid:%@ ,unionid:%@ ,refresh_token:%@ ,expirationDate:%@ access_token:%@ , userName:%@ , iconURL:%@ ,usid:%@ ,profileURL:%@",snsAccount.platformName,snsAccount.openId,snsAccount.unionId,snsAccount.refreshToken,expirationDate,snsAccount.accessToken,snsAccount.userName,snsAccount.iconURL,snsAccount.usid,snsAccount.profileURL );
//        NSDictionary *dic = @{@"openid":snsAccount.openId,
//          @"unionid":snsAccount.unionId,
//          @"refresh_token":snsAccount.refreshToken,
//          @"access_token":snsAccount.accessToken,
//          @"usid":snsAccount.usid,
//          @"provider":@"wx"
//        };
//        
//        block(dic);
//        
//      }else if(response.responseCode == UMSResponseCodeCancel){
//        DGCAlertController *ac = [DGCAlertController alertControllerWithTitle:@"" message:@"用户取消微信登录" type:DGCAlertTypeJustConfirm block:nil];
//        [viewController presentViewController:ac animated:YES completion:nil];
//      }else{
//        DGCAlertController *ac = [DGCAlertController alertControllerWithTitle:@"" message:@"微信登录失败" type:DGCAlertTypeJustConfirm block:nil];
//        [viewController presentViewController:ac animated:YES completion:nil];
//      }
//    });
//    
//    
//    //在授权完成后调用获取用户信息的方法
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession completion:^(UMSocialResponseEntity *response) {
//      DLog(@"微信SnsInformation is %@",response.data);
//      }];
    
    
    /*
     typedef void (^UMSocialSnsPlatformLoginHandler)(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController, UMSocialDataServiceCompletion completion);
     
     typedef void (^UMSocialDataServiceCompletion)(UMSocialResponseEntity * response);
     */
    let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
    
    let completion:UMSocialDataServiceCompletion = {(response:UMSocialResponseEntity?)->Void in
      
    }
    
    snsPlatform.loginClickHandler!(viewController,
                                   UMSocialControllerService.defaultControllerService(),
                                   true,
                                   completion)
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}