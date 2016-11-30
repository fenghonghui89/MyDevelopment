//
//  MDSettingViewController.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDSettingViewController.h"
#import "MDGlobalManager.h"
#import "MDPushNotificationManager.h"

@interface MDSettingViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;

@end

@implementation MDSettingViewController

#pragma mark - overwrite
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.notificationSwitch.on = [MDGlobalManager sharedInstance].isOpenNotification;
  [self checkSystemSettingIsOpen];
}


#pragma mark - method

-(NSString *)systemNotifictionSetting{
  
  NSString *systemNotifictionSetting = nil;
  if ((floor)(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_9_x_Max) {
    systemNotifictionSetting = @"prefs:root=NOTIFICATIONS_ID&path=com.HanyAppDevPush.test";
  }else{
    systemNotifictionSetting = UIApplicationOpenSettingsURLString;
  }
  
  return systemNotifictionSetting;
}

-(void)checkSystemSettingIsOpen{
  
  /*
   检测到标识为”接收推送“
   - 检测没有打开系统推送，提示用户打开
   检测到标识为”不接收推送“
   - 不处理
   */
  BOOL on = self.notificationSwitch.on;
  NSInteger count = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
  ULog(@"on..%d count..%ld",on,(long)count);
  
  if(on)
  {
    if (count <= 0)
    {
      UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请打开系统推送开关" message:@"请打开系统推送开关，否则无法收到推送。是否到“设置”打开推送开关" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *aa1 = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:[self systemNotifictionSetting]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
          [[UIApplication sharedApplication] openURL:url];
        }
      }];
      UIAlertAction *aa2 = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
      }];
      [ac addAction:aa1];
      [ac addAction:aa2];
      [self.navigationController presentViewController:ac animated:YES completion:nil];
    }
  }
}

#pragma mark - action
- (IBAction)goToSystemSettingBtnTap:(id)sender {
  NSURL *url = [NSURL URLWithString:[self systemNotifictionSetting]];
  if ([[UIApplication sharedApplication] canOpenURL:url]) {
    [[UIApplication sharedApplication] openURL:url];
  }
}

- (IBAction)messageBtnTap:(id)sender {
  
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  //删除对应的通知
}


- (IBAction)switchValueChange:(UISwitch *)sender {
  
  ULog(@"switch on..%d",sender.on);
  
  //设置标识
  [MDGlobalManager sharedInstance].isOpenNotification = sender.on;
  
  
  /*
   打开接收推送
   - 检测没有打开系统推送，提示用户打开
   - 检测已经打开系统推送，则注册通知
   关闭接收推送
   - 注销推送
   */
  BOOL on = self.notificationSwitch.on;
  NSInteger count = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
  
  if(on)
  {
    if (count <= 0)
    {
      UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请\"先\"打开系统推送开关" message:@"请\"先\"打开系统推送开关，再回来设置接收推送，否则无法收到推送。是否到“设置”打开推送开关" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *aa1 = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:[self systemNotifictionSetting]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
          [[UIApplication sharedApplication] openURL:url];
        }
      }];
      UIAlertAction *aa2 = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
      }];
      [ac addAction:aa1];
      [ac addAction:aa2];
      [self.navigationController presentViewController:ac animated:YES completion:^{
        sender.on = NO;//按钮复位
      }];
    }
    else
    {
      [[MDPushNotificationManager sharedInstance] registerNotification];
    }
  }
  else
  {
    [[MDPushNotificationManager sharedInstance] cancleAllNotifications];
  }
  
  
  
  
}

@end
