//
//  ViewController.m
//  OneAllTest
//
//  Created by 冯鸿辉 on 2016/12/7.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController.h"
#import <OneAll/OneAll.h>
static NSString *const kProviderFacebook = @"facebook";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)btnTap:(id)sender {
  
  
  [[OAManager sharedInstance] loginWithSuccess:^(OAUser *user, BOOL newUser) {
    NSLog(@"User logged in..: %@", user);
  } andFailure:^(NSError *error) {
    NSLog(@"Failed to login user..: %@, %@", error.localizedDescription, error.userInfo);
  }];
}

- (IBAction)btn1Tpa:(id)sender {
  
  [[OAManager sharedInstance] loginWithProvider:kProviderFacebook success:^(OAUser *user, BOOL newUser) {
    NSLog(@"Login succeeded..%@",user.pictureUrl);
  } failure:^(NSError *error) {
    NSLog(@"Login failed..");
  }];
}

@end
