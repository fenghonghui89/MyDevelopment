//
//  ViewController.m
//  FacebookTest
//
//  Created by 冯鸿辉 on 2016/12/5.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

}



- (IBAction)showBtnTap:(id)sender {
  
  if ([FBSDKAccessToken currentAccessToken]) {
    self.label.text = [FBSDKAccessToken currentAccessToken].tokenString;
  }else{
    self.label.text = @"no login";
  }
}


@end
