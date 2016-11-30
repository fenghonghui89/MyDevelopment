//
//  ViewController.m
//  FCMTest
//
//  Created by 冯鸿辉 on 2016/11/22.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController.h"
#import "MDGlobalManager.h"
#import "MDSettingViewController.h"
#import "MDInfoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  
  if ([[MDGlobalManager sharedInstance] getStoreData]) {
    MDInfoViewController *vc = [[MDInfoViewController alloc] initWithNibName:@"MDInfoViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
  }
}



- (IBAction)btnTap:(id)sender {
  MDSettingViewController *vc = [[MDSettingViewController alloc] initWithNibName:@"MDSettingViewController" bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)infoBtnTap:(id)sender {
  MDInfoViewController *vc = [[MDInfoViewController alloc] initWithNibName:@"MDInfoViewController" bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];

}

@end
