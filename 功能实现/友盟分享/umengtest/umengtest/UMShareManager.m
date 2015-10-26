//
//  UMShareManager.m
//  umengtest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "UMShareManager.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialControllerService.h"
@interface UMShareManager()
<
UMSocialUIDelegate
>
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
    [UMSocialData setAppKey:@"56245c1f67e58efb0e00381f"];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wx1f62cb4c780d3b35" appSecret:@"2571591bfa4bffe8d8fbb31f65fe9278" url:@"http://www.umeng.com/social"];
    
    //QQ登录只支持SSO登录方式，必须具备手机QQ客户端，Qzone默认调用SSO登录
    [UMSocialQQHandler setQQWithAppId:@"1104841257" appKey:@"rpzl87aDJpwXgBLT" url:@"http://www.umeng.com/social"];
}

-(BOOL)handleOpenURL:(NSURL *)url
{
  return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - < action > -
-(void)wechatLogin:(UIViewController *)viewController
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [userDefault objectForKey:@"hasLogin"];
    BOOL hasLogin = [data boolValue];
    
    if (hasLogin) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
        return;
    }
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"me - 返回的responseCode:%d",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //保存登录状态
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"hasLogin"];
            [userDefaults synchronize];
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSString *str = [NSString stringWithFormat:@"微信登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
            NSLog(@"%@",str);
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"微信登录成功" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else if(response.responseCode == UMSResponseCodeCancel){
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消微信登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微信登录失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    });
    
    //在授权完成后调用获取用户信息的方法
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession completion:^(UMSocialResponseEntity *response) {
        NSLog(@"微信SnsInformation is %@",response.data);
    }];
}

-(void)weiboLogin:(UIViewController *)viewController
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [userDefault objectForKey:@"hasLogin"];
    BOOL hasLogin = [data boolValue];
    
    if (hasLogin) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
        return;
    }

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"me - 返回的responseCode:%d",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //保存登录状态
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"hasLogin"];
            [userDefaults synchronize];
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSString *str = [NSString stringWithFormat:@"微博登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
            NSLog(@"%@",str);
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else if(response.responseCode == UMSResponseCodeCancel){
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消微博登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微博登录失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    });
    
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"微博SnsInformation is %@",response.data);
    }];
}

-(void)qqlogin:(UIViewController *)viewController
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [userDefault objectForKey:@"hasLogin"];
    BOOL hasLogin = [data boolValue];
    
    if (hasLogin) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
        return;
    }

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"me - 返回的responseCode:%d",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //保存登录状态
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"hasLogin"];
            [userDefaults synchronize];
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSString *str = [NSString stringWithFormat:@"qq登录成功\nusername is %@,\n uid is %@,\n token is %@ url is %@\n",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL];
            NSLog(@"%@",str);
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else if(response.responseCode == UMSResponseCodeCancel){
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消qq登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"qq登录失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    });
    
    //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
}

-(void)share:(UIViewController *)viewController
   shareText:(NSString *)shareText
  shareImage:(UIImage *)shareImage
{
    //sheetview形式
    [UMSocialSnsService presentSnsIconSheetView:viewController
                                         appKey:@"56245c1f67e58efb0e00381f"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
                                       delegate:self];
    
    //tableview形式
//    [UMSocialSnsService presentSnsController:self
//                                      appKey:@"56245c1f67e58efb0e00381f"
//                                   shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
//                                  shareImage:[UIImage imageNamed:@"UMS_douban_icon.png"]
//                             shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
//                                    delegate:self];

}

-(void)logout:(LoginType)loginType
{
    switch (loginType) {
        case LoginTypeWeChat:
        {
            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"微信注销response is %@",response);
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微信注销成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [av show];
            }];
        }
            
            break;
        case LoginTypeWeibo:
        {
            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                NSLog(@"微博注销response is %@",response);
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"微博注销成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [av show];
            }];
        }
            
            break;
        case LoginTypeQQ:
        {
            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
                NSLog(@"qq注销response is %@",response);
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"qq注销成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [av show];
            }];
        }
            break;
        default:
            break;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"hasLogin"];
    [userDefault synchronize];
}

#pragma mark - < callback > -
//各个页面执行授权完成、分享完成、或者评论完成时的回调函数可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"me - 各个页面执行授权完成、分享完成、或者评论完成时的回调函数");

    if(response.responseCode == UMSResponseCodeSuccess){
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
    }else{
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
    }
}
@end
