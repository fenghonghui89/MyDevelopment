//
//  DGCShareManager.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/2/15.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCShareManager.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialControllerService.h"
#import "UMSocialInstagramHandler.h"
#import "UMSocialFacebookHandler.h"
#import "UMSocialTwitterHandler.h"
#import "DGCDefine.h"
@interface DGCShareManager()
<
UMSocialUIDelegate
>
@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,weak)id<DGCShareManagerDelegate> delegate;
@end
@implementation DGCShareManager

+(DGCShareManager *)shareInstance{
  static dispatch_once_t once;
  static DGCShareManager *shareInstance;
  dispatch_once(&once, ^{
    shareInstance = [[DGCShareManager alloc] init];
  });
  return shareInstance;
}

-(void)startUMShare
{
  //设置友盟社会化组件appkey
  [UMSocialData setAppKey:UMENG_APPKEY];
  
  //打开调试log的开关
  [UMSocialData openLog:YES];
  
  //设置微信AppId，设置分享url，默认使用友盟的网址
  [UMSocialWechatHandler setWXAppId:UMENG_WECHAT_APPID appSecret:UMENG_WECHAT_APPSECRET url:UMENG_URL];
  
  //新浪微博
  [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:UMENG_WEIBO_APPKEY secret:UMENT_WEIBO_SECRET RedirectURL:UMENG_URL];
  
  //QQ登录只支持SSO登录方式，必须具备手机QQ客户端，Qzone默认调用SSO登录
  [UMSocialQQHandler setQQWithAppId:UMENG_QQ_APPID appKey:UMENG_QQ_APPKEY url:UMENG_URL];
  
//  //facebook
//  [UMSocialFacebookHandler setFacebookAppID:@"" shareFacebookWithURL:@""];
//
//  //Twitter
//  //默认使用iOS自带的Twitter分享framework，在iOS 6以上有效。若要使用我们提供的twitter分享需要使用此开关：
//  [UMSocialTwitterHandler openTwitter];
//  // 集成的TwitterSDK仅在iOS7.0以上有效，在iOS 6.x上自动调用系统内置Twitter授权
//  if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//    [UMSocialTwitterHandler setTwitterAppKey:@"fB5tvRpna1CKK97xZUslbxiet" withSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K"];
//  }
  
  //InstagramHandler
  [UMSocialInstagramHandler openInstagramWithScale:NO paddingColor:[UIColor blackColor]];
}

-(BOOL)handleOpenURL:(NSURL *)url
{
  return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - < action > -
-(void)share:(UIViewController *)viewController
    delegate:(id<DGCShareManagerDelegate>)delegate
       title:(NSString *)title
   shareText:(NSString *)shareText
         url:(NSString *)urlstring
      imgUrl:(NSString *)imgUrlString
{
  self.vc = viewController;
  self.delegate = delegate;
  
  [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstring;
  [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstring;
  [UMSocialData defaultData].extConfig.qqData.url = urlstring;
  [UMSocialData defaultData].extConfig.qzoneData.url = urlstring;
  
  [UMSocialData defaultData].extConfig.qqData.title = title;
  [UMSocialData defaultData].extConfig.qzoneData.title = title;
  [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
  [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
  
  [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imgUrlString];
  
  //如果没有装客户端则隐藏
  [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
  
  //qq
  [UMSocialQQHandler setQQWithAppId:UMENG_QQ_APPID appKey:UMENG_QQ_APPKEY url:urlstring];
  
  //sheetview形式
  [UMSocialSnsService presentSnsIconSheetView:viewController
                                       appKey:UMENG_APPKEY
                                    shareText:shareText
                                   shareImage:nil
                              shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToInstagram]
                                     delegate:self];
//  @[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToInstagram]
}

-(void)wechatLogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block
{
  UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
  
  snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    DLog(@"微信返回的responseCode:%d",response.responseCode);
    if (response.responseCode == UMSResponseCodeSuccess) {
      UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
      
      NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
      [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
      NSString *expirationDate = [formatter stringFromDate:snsAccount.expirationDate];
      DLog(@"微信登录成功platformName:%@ ,openid:%@ ,unionid:%@ ,refresh_token:%@ ,expirationDate:%@ access_token:%@ , userName:%@ , iconURL:%@ ,usid:%@ ,profileURL:%@",snsAccount.platformName,snsAccount.openId,snsAccount.unionId,snsAccount.refreshToken,expirationDate,snsAccount.accessToken,snsAccount.userName,snsAccount.iconURL,snsAccount.usid,snsAccount.profileURL );
      
      NSDictionary *dic = @{@"openid":snsAccount.openId,
                            @"unionid":snsAccount.unionId,
                            @"refresh_token":snsAccount.refreshToken,
                            @"access_token":snsAccount.accessToken,
                            @"usid":snsAccount.usid,
                            };
      
      block(dic);
      
    }else if(response.responseCode == UMSResponseCodeCancel){
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"用户取消微信登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
      [av show];
    }else{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"微信登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
      [av show];
    }
  });
  
  
  //在授权完成后调用获取用户信息的方法
  [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession completion:^(UMSocialResponseEntity *response) {
    DLog(@"微信SnsInformation is %@",response.data);
  }];
}

-(void)qqlogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block
{
  UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
  
  snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    DLog(@"QQ返回的responseCode:%d",response.responseCode);
    if (response.responseCode == UMSResponseCodeSuccess) {
      UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToQQ];
      NSString *str = [NSString stringWithFormat:@"QQ登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
      DLog(@"%@",str);;
    }else if(response.responseCode == UMSResponseCodeCancel){
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"用户取消QQ登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
      [av show];
    }else{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"QQ登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
      [av show];
    }
  });
  
  //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
  [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
    NSLog(@"SnsInformation is %@",response.data);
  }];
}

-(void)weiboLogin:(UIViewController *)viewController block:(void(^)(NSDictionary *paramDic))block
{
  UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
  
  snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    DLog(@"QQ返回的responseCode:%d",response.responseCode);
    if (response.responseCode == UMSResponseCodeSuccess) {
      UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToSina];
      NSString *str = [NSString stringWithFormat:@"QQ登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
      DLog(@"%@",str);;
    }else if(response.responseCode == UMSResponseCodeCancel){
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"用户取消QQ登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
      [av show];
    }else{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"QQ登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
      [av show];
    }
  });
  
  //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
  [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
    NSLog(@"SnsInformation is %@",response.data);
  }];
}

#pragma mark - < callback > -
//各个页面执行授权完成、分享完成、或者评论完成时的回调函数可选）：分享成功后停留在平台不会有回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
  NSString *platformName = [[response.data allKeys] objectAtIndex:0];
  DLog(@"各个页面执行授权完成、分享完成、或者评论完成时的回调函数 %@",platformName);
  
  if(response.responseCode == UMSResponseCodeSuccess){
    DLog(@"分享成功的平台名字 %@",platformName);
    [self.delegate shareManager:self shareDidFinish:YES];
  }else{
    DLog(@"分享失败的平台名字 %@",platformName);
    [self.delegate shareManager:self shareDidFinish:NO];
  }
}


@end
