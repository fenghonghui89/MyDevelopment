//
//  UMShareManager.m
//  umengtest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#define UMENG_APPKEY @"5976bce9b27b0a243200031c"
#define UMENG_URL @"http://tpages.cn"

#define UMENG_WECHAT_APPID @"wxa9cec0d7b7d9d1f1"
#define UMENG_WECHAT_APPSECRET @"b2878be2a0922637868ff90f47351517"
#define UMENG_WECHAT_URL @"http://tpages.cn/qqcb"

#define UMENG_QQ_APPID @"1105220570"
#define UMENG_QQ_APPKEY @"Q8W9L5bJT8TFVJkc"
#define UMENG_QQ_URL @"http://tpages.cn/qqcb"

#define UMENG_WEIBO_APPKEY @"1234731486"
#define UMENG_WEIBO_SECRET @"3a21eec0820508abc92ecedee90f381a"
#define UMENG_WEIBO_URL @"https://sns.whalecloud.com/sina2/callback"

#define UMENG_SHARE_BASEURL @"http://90days.tpages.cn/comments.html#"

#import "UMShareManager.h"


@interface UMShareManager()

@end

@implementation UMShareManager
+(UMShareManager *)share
{
    static UMShareManager *share = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        share = [[self alloc] init];
    });
    
    return share;
}

-(void)startUMShare
{
    //设置友盟社会化组件appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMENG_APPKEY];
    
    //打开调试log的开关
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:UMENG_WECHAT_APPID appSecret:UMENG_WECHAT_APPSECRET redirectURL:UMENG_WECHAT_URL];
  
    //QQ登录只支持SSO登录方式，必须具备手机QQ客户端，Qzone默认调用SSO登录
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:UMENG_QQ_APPID  appSecret:nil redirectURL:UMENG_QQ_URL];
    
    //新浪微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:UMENG_WEIBO_APPKEY appSecret:UMENG_WEIBO_SECRET redirectURL:UMENG_WEIBO_URL];
}


#pragma mark - < handle open url >

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark - < action > -
-(void)wechatLogin:(UIViewController *)viewController
{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSNumber *data = [userDefault objectForKey:@"hasLogin"];
//    BOOL hasLogin = [data boolValue];
//    
//    if (hasLogin) {
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [av show];
//        return;
//    }
//    
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        NSLog(@"me - 返回的responseCode:%d",response.responseCode);
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            //保存登录状态
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"hasLogin"];
//            [userDefaults synchronize];
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//            NSString *str = [NSString stringWithFormat:@"微信登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
//            NSLog(@"%@",str);
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"微信登录成功" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }else if(response.responseCode == UMSResponseCodeCancel){
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消微信登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }else{
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微信登录失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }
//    });
//    
//    //在授权完成后调用获取用户信息的方法
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession completion:^(UMSocialResponseEntity *response) {
//        NSLog(@"微信SnsInformation is %@",response.data);
//    }];
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"wechat error..%@",error.localizedDescription);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

-(void)weiboLogin:(UIViewController *)viewController
{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSNumber *data = [userDefault objectForKey:@"hasLogin"];
//    BOOL hasLogin = [data boolValue];
//    
//    if (hasLogin) {
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [av show];
//        return;
//    }
//
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        NSLog(@"me - 返回的responseCode:%d",response.responseCode);
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            //保存登录状态
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"hasLogin"];
//            [userDefaults synchronize];
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//            NSString *str = [NSString stringWithFormat:@"微博登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
//            NSLog(@"%@",str);
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }else if(response.responseCode == UMSResponseCodeCancel){
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消微博登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }else{
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微博登录失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }
//    });
//    
//    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"微博SnsInformation is %@",response.data);
//    }];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"wechat error..%@",error.localizedDescription);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}

-(void)qqlogin:(UIViewController *)viewController
{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSNumber *data = [userDefault objectForKey:@"hasLogin"];
//    BOOL hasLogin = [data boolValue];
//    
//    if (hasLogin) {
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [av show];
//        return;
//    }
//
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        NSLog(@"me - 返回的responseCode:%d",response.responseCode);
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            //保存登录状态
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"hasLogin"];
//            [userDefaults synchronize];
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//            NSString *str = [NSString stringWithFormat:@"qq登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
//            NSLog(@"%@",str);
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }else if(response.responseCode == UMSResponseCodeCancel){
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消qq登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }else{
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"qq登录失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
//        }
//    });
//    
//    //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"SnsInformation is %@",response.data);
//    }];
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"wechat error..%@",error.localizedDescription);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}

-(void)share:(UIViewController *)viewController
   shareText:(NSString *)shareText
  shareImage:(UIImage *)shareImage
{
//    //sheetview形式
//    [UMSocialSnsService presentSnsIconSheetView:viewController
//                                         appKey:UMENG_APPKEY
//                                      shareText:shareText
//                                     shareImage:shareImage
//                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
//                                       delegate:self];
//    
    //tableview形式
//    [UMSocialSnsService presentSnsController:self
//                                      appKey:@"56245c1f67e58efb0e00381f"
//                                   shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
//                                  shareImage:[UIImage imageNamed:@"UMS_douban_icon.png"]
//                             shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
//                                    delegate:self];
    
    

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType controller:(UIViewController *)controller
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

-(void)share:(UIViewController *)viewController
       title:(NSString *)title
   shareText:(NSString *)shareText
  shareImage:(UIImage *)shareImage
         url:(NSString *)urlstring
{
//  [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstring;
//  [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstring;
//  [UMSocialData defaultData].extConfig.qqData.url = urlstring;
//  [UMSocialData defaultData].extConfig.qzoneData.url = urlstring;
//  
//  [UMSocialData defaultData].extConfig.qqData.title = title;
//  [UMSocialData defaultData].extConfig.qzoneData.title = title;
//  [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
//  [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
//  
//  [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
//  
//  //如果没有装客户端则隐藏
//  [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
//  
//  //qq
//  [UMSocialQQHandler setQQWithAppId:UMENG_QQ_APPID appKey:UMENG_QQ_APPKEY url:urlstring];
//  
//  //sheetview形式
//  [UMSocialSnsService presentSnsIconSheetView:viewController
//                                       appKey:UMENG_APPKEY
//                                    shareText:shareText
//                                   shareImage:nil
//                              shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]
//                                     delegate:self];
  
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
}

-(void)logout:(LoginType)loginType
{
//    switch (loginType) {
//        case LoginTypeWeChat:
//        {
//            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
//                NSLog(@"微信注销response is %@",response);
//                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微信注销成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [av show];
//            }];
//        }
//            
//            break;
//        case LoginTypeWeibo:
//        {
//            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//                NSLog(@"微博注销response is %@",response);
//                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微博注销成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [av show];
//            }];
//        }
//            
//            break;
//        case LoginTypeQQ:
//        {
//            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
//                NSLog(@"qq注销response is %@",response);
//                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"qq注销成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [av show];
//            }];
//        }
//            break;
//        default:
//            break;
//    }
//    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault removeObjectForKey:@"hasLogin"];
//    [userDefault synchronize];
}

#pragma mark - < callback > -
//各个页面执行授权完成、分享完成、或者评论完成时的回调函数可选）：
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    NSLog(@"me - 各个页面执行授权完成、分享完成、或者评论完成时的回调函数");
//
//    if(response.responseCode == UMSResponseCodeSuccess){
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [av show];
//    }else{
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [av show];
//    }
//}
@end
