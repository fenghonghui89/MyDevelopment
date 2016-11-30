//
//  MDInfoViewController.m
//  FCMTest
//
//  Created by 冯鸿辉 on 2016/11/30.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "MDInfoViewController.h"
#import "MDGlobalManager.h"

@interface MDInfoViewController ()

@end

@implementation MDInfoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[MDGlobalManager sharedInstance] deleteStoreData];
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}



@end
