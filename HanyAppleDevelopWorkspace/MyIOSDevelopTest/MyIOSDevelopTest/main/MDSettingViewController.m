//
//  MDSettingViewController.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDSettingViewController.h"
#import "MDGlobalManager.h"
#import "MDLocalNotificationManager.h"
@interface MDSettingViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;

@end

@implementation MDSettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.notificationSwitch.on = [MDGlobalManager sharedInstance].isOpenNotification;
  [self checkSystemSetting];
}

-(void)checkSystemSetting{
  
  BOOL on = self.notificationSwitch.on;
  NSInteger count = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
  ULog(@"on..%d count..%d",on,count);
  
  if(on)
  {
    if (count <= 0)
    {
      UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"你设置接收推送内容，但系统推送开关没有打开" message:@"是否到“设置”打开推送开关" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *aa1 = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
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

- (IBAction)messageBtnTap:(id)sender {
  
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (IBAction)switchValueChange:(UISwitch *)sender {
  
  ULog(@"switch on..%d",sender.on);
  
  [MDGlobalManager sharedInstance].isOpenNotification = sender.on;
  
  if(sender.on)
  {
    [[MDLocalNotificationManager sharedInstance] registerLocalNotification];
  }
  else
  {
    [[MDLocalNotificationManager sharedInstance] cancleAllNotifications];
  }

}

@end
