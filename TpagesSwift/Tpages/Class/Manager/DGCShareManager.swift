//
//  DGCShareManager.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/11.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCShareManager:NSObject,UMSocialUIDelegate {
  
  var vc:UIViewController?
  
  static let sharedInstance:DGCShareManager = {
    let instance = DGCShareManager()
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
  
  //MARK:- < action > -
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
    UMSocialSnsService.presentSnsIconSheetView(viewController,
                                            appKey: UMENG_APPKEY,
                                            shareText: shareText,
                                            shareImage: nil,
                                            shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone],
                                            delegate: self)
  }
  
  
  
  func wechatLogin(viewController:UIViewController,block:(paramDic:NSDictionary)->Void) {
    
    let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
    
    let completion:UMSocialDataServiceCompletion = {(response:UMSocialResponseEntity?)->Void in
      
      dlog("微信返回的responseCode：\(response?.responseCode)")
      
      //登录成功
      if response?.responseCode == UMSResponseCodeSuccess {
        let snsAccount:UMSocialAccountEntity = UMSocialAccountManager.socialAccountDictionary()[UMShareToWechatSession] as! UMSocialAccountEntity
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        let expirationDate:String = formatter.stringFromDate(snsAccount.expirationDate)
        
        dlog("微信登录成功platformName:\(snsAccount.platformName)," +
          "openid:\(snsAccount.openId)," +
          "unionid:\(snsAccount.unionId)," +
          "refresh_token:\(snsAccount.refreshToken)," +
          "expirationDate:\(expirationDate)," +
          "access_token:\(snsAccount.accessToken)," +
          "userName:\(snsAccount.userName)," +
          "iconURL:\(snsAccount.iconURL)," +
          "usid:\(snsAccount.usid)," +
          "profileURL:\(snsAccount.profileURL)")
        
        let dic = ["openid":snsAccount.openId,
                   "unionid":snsAccount.unionId,
                   "refresh_token":snsAccount.refreshToken,
                   "access_token":snsAccount.accessToken,
                   "usid":snsAccount.usid,
                   "provider":"wx"]
        block(paramDic: dic);
      }
        
        //取消登录
      else if response?.responseCode == UMSResponseCodeCancel{
        let ac = DGCAlertController.alertControlller("", message: "用户取消微信登录", type:DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        viewController.presentViewController(ac, animated: true, completion: nil)
      }
        
        //登录失败
      else{
        let ac = DGCAlertController.alertControlller("", message: "微信登录失败", type:DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        viewController.presentViewController(ac, animated: true, completion: nil)
      }
    }
    
    snsPlatform.loginClickHandler!(viewController,
                                   UMSocialControllerService.defaultControllerService(),
                                   true,completion)
    
    UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToWechatSession) { (response:UMSocialResponseEntity?) in
      dlog("微信SnsInformation is \(response?.data)")
    }
    
  }

  
  func qqLogin(viewController:UIViewController,block:(paramDic:NSDictionary)->Void) {
    
    let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
    
    let completion:UMSocialDataServiceCompletion = {(response:UMSocialResponseEntity?)->Void in
      
      dlog("qq返回的responseCode：\(response?.responseCode)")
      
      //登录成功
      if response?.responseCode == UMSResponseCodeSuccess {
        let snsAccount:UMSocialAccountEntity = UMSocialAccountManager.socialAccountDictionary()[UMShareToQQ] as! UMSocialAccountEntity
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        let expirationDate:String = formatter.stringFromDate(snsAccount.expirationDate)
        
        dlog("qq登录成功platformName:\(snsAccount.platformName)," +
          "openid:\(snsAccount.openId)," +
          "unionid:\(snsAccount.unionId)," +
          "refresh_token:\(snsAccount.refreshToken)," +
          "expirationDate:\(expirationDate)," +
          "access_token:\(snsAccount.accessToken)," +
          "userName:\(snsAccount.userName)," +
          "iconURL:\(snsAccount.iconURL)," +
          "usid:\(snsAccount.usid)," +
          "profileURL:\(snsAccount.profileURL)")
        

        
        let dic = ["openid":snsAccount.openId,
                   "access_token":snsAccount.accessToken,
                   "usid":snsAccount.usid,
                   "oauth_consumer_key":UMENG_QQ_APPID,
                   "provider":"qq"]
        block(paramDic: dic);
      }
        
        //取消登录
      else if response?.responseCode == UMSResponseCodeCancel{
        let ac = DGCAlertController.alertControlller("", message: "用户取消qq登录", type:DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        viewController.presentViewController(ac, animated: true, completion: nil)
      }
        
        //登录失败
      else{
        let ac = DGCAlertController.alertControlller("", message: "qq登录失败", type:DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        viewController.presentViewController(ac, animated: true, completion: nil)
      }
    }
    
    snsPlatform.loginClickHandler!(viewController,
                                   UMSocialControllerService.defaultControllerService(),
                                   true,completion)
    
    UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToQQ) { (response:UMSocialResponseEntity?) in
      dlog("qqSnsInformation is \(response?.data)")
    }
    
  }
  
  func weiboLogin(viewController:UIViewController,block:(paramDic:NSDictionary)->Void) {
    
    let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
    
    let completion:UMSocialDataServiceCompletion = {(response:UMSocialResponseEntity?)->Void in
      
      dlog("新浪微博返回的responseCode：\(response?.responseCode)")
      
      //登录成功
      if response?.responseCode == UMSResponseCodeSuccess {
        let snsAccount:UMSocialAccountEntity = UMSocialAccountManager.socialAccountDictionary()[UMShareToSina] as! UMSocialAccountEntity
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        let expirationDate:String = formatter.stringFromDate(snsAccount.expirationDate)
        
        dlog("新浪微博登录成功platformName:\(snsAccount.platformName)," +
          "openid:\(snsAccount.openId)," +
          "unionid:\(snsAccount.unionId)," +
          "refresh_token:\(snsAccount.refreshToken)," +
          "expirationDate:\(expirationDate)," +
          "access_token:\(snsAccount.accessToken)," +
          "userName:\(snsAccount.userName)," +
          "iconURL:\(snsAccount.iconURL)," +
          "usid:\(snsAccount.usid)," +
          "profileURL:\(snsAccount.profileURL)")
        
        
        let dic = ["access_token":snsAccount.accessToken,
                   "usid":snsAccount.usid,
                   "screen_name":snsAccount.userName,
                   "provider":"sina"]
        block(paramDic: dic);
      }
        
        //取消登录
      else if response?.responseCode == UMSResponseCodeCancel{
        let ac = DGCAlertController.alertControlller("", message: "用户取消新浪微博登录", type:DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        viewController.presentViewController(ac, animated: true, completion: nil)
      }
        
        //登录失败
      else{
        let ac = DGCAlertController.alertControlller("", message: "新浪微博登录失败", type:DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        viewController.presentViewController(ac, animated: true, completion: nil)
      }
    }
    
    snsPlatform.loginClickHandler!(viewController,
                                   UMSocialControllerService.defaultControllerService(),
                                   true,completion)
    
    UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToSina) { (response:UMSocialResponseEntity?) in
      dlog("新浪微博SnsInformation is \(response?.data)")
    }
    
  }
  
  //MARK:- < callback > -
  //各个页面执行授权完成、分享完成、或者评论完成时的回调函数可选）：分享成功后停留在平台不会有回调
  func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
    
    let platform = Array(response.data.keys)[0]
    
    if response.responseCode == UMSResponseCodeSuccess {
      dlog("分享成功的平台名字 \(platform)")
    }else{
      dlog("分享失败的平台名字 \(platform)")
    }
  }
  
  
  
}