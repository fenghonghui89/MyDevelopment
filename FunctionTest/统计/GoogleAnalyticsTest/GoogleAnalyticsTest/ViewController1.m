//
//  ViewController1.m
//  GoogleAnalyticsTest
//
//  Created by 冯鸿辉 on 2016/11/15.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController1.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}


- (IBAction)btnTap:(id)sender {
  
  id tracker = [[GAI sharedInstance] defaultTracker];
  [tracker set:kGAIScreenName value:@"页面2"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


@end
