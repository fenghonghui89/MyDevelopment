//
//  AppDelegate.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-14.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//



#import "HFAppDelegate.h"

#import "HFMenuViewController.h"
#import "HFWelcomeViewController.h"
#import "HFTabBarController.h"
#import "SliderViewController.h"

#import "CoreDataSettingManager.h"
#import "UserInfo.h"
#import "WeiboSDK.h"

@interface HFAppDelegate()<WeiboSDKDelegate>


@end

@implementation HFAppDelegate



-(void)dealloc{
    [_window release];
    _window = nil;
    [_loginVC release];
    _loginVC = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"*%@-%@",NSStringFromClass([self class]),[[NSBundle mainBundle] resourcePath]);
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease] ;
    [_window setBackgroundColor:[UIColor redColor]];
    
    //判断是否第一次运行，是否已经登录
    if ([[[CoreDataSettingManager shareManager] findSettingWithOption:@"isFirstRun"] boolValue] == YES) {
        
        [[CoreDataSettingManager shareManager] changeSettingWithOption:@"isFirstRun" andValue:[NSNumber numberWithBool:NO]];
        
        HFWelcomeViewController *welcomeVC = [[HFWelcomeViewController alloc] init];
        _window.rootViewController = welcomeVC;
        [welcomeVC release];
        
    }else{
        UserInfo *userInfo = [[CoreDataSettingManager shareManager] findSettingWithOption:@"userInfo"];
        
        if (userInfo == nil) {//没有登录
            _loginVC = [[HFLoginViewController alloc] initWithNibName:@"HFLoginViewController" bundle:nil];
            _window.rootViewController = _loginVC;
        }else{//已经登录
            HFTabBarController *tabbarC = [[HFTabBarController alloc] init];
            [[SliderViewController sharedSliderController] setMainVC:tabbarC];
            [tabbarC release];
            
            HFMenuViewController *menuVC = [[HFMenuViewController alloc] initWithNibName:@"HFMenuViewController" bundle:nil];
            [[SliderViewController sharedSliderController] setLeftVC:menuVC];
            [SliderViewController sharedSliderController].LeftSCloseDuration = 0.4;
            [SliderViewController sharedSliderController].LeftSOpenDuration = 0.4;
            [SliderViewController sharedSliderController].LeftSContentScale = 1.0;
            [SliderViewController sharedSliderController].LeftSContentOffset = 220.0;
            [SliderViewController sharedSliderController].LeftSJudgeOffset = 160;
            [menuVC release];
            
            _window.rootViewController = [SliderViewController sharedSliderController];
        }
    }
    
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //weiboSDK
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:AppKey];
    
    return YES;
}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDKDelegate协议方法
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"*%@-didReceiveWeiboResponse",NSStringFromClass([self class]));
    
    //登陆应答--登陆成功--修改token存档--推出界面
    if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            
            //修改token和userID
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.access_token = ((WBAuthorizeResponse *)response).accessToken;
            userInfo.uid = ((WBAuthorizeResponse *)response).userID;
            
            [[CoreDataSettingManager shareManager] changeSettingWithOption:@"userInfo" andValue:userInfo];
            [userInfo release];
            
            //进入tabbar
            HFTabBarController *tabbarC = [[HFTabBarController alloc] init];
            [[SliderViewController sharedSliderController] setMainVC:tabbarC];
            [tabbarC release];
            
            HFMenuViewController *menuVC = [[HFMenuViewController alloc] initWithNibName:@"HFMenuViewController" bundle:nil];
            [[SliderViewController sharedSliderController] setLeftVC:menuVC];
            [SliderViewController sharedSliderController].LeftSCloseDuration = 0.4;
            [SliderViewController sharedSliderController].LeftSOpenDuration = 0.4;
            [SliderViewController sharedSliderController].LeftSContentScale = 1.0;
            [SliderViewController sharedSliderController].LeftSContentOffset = 220.0;
            [SliderViewController sharedSliderController].LeftSJudgeOffset = 160.0;
            [menuVC release];
            
            [self.loginVC presentViewController:[SliderViewController sharedSliderController] animated:YES completion:nil];
        }
    }
}

@end
