//
//  MD_Reachability_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/30.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Reachability_VC.h"
#import "ReachabilityManager.h"
#import "Reachability.h"
@interface MD_Reachability_VC ()

@end

@implementation MD_Reachability_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self test];
}


#pragma mark - < method > -

#pragma mark 直接用Reachability
-(void)test{
  
  //host
    Reachability * hostreach = [Reachability reachabilityWithHostname:@"http://www.3hmlg.com"];
  
  hostreach.reachableBlock = ^(Reachability * reachability)
  {
    dispatch_async(dispatch_get_main_queue(), ^{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"host Block Says Reachable" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
      [av show];
    });
  };
  
  hostreach.unreachableBlock = ^(Reachability * reachability)
  {
    dispatch_async(dispatch_get_main_queue(), ^{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"host Block Says Unreachable" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
      [av show];
    });
  };
  
  [hostreach startNotifier];

}

#pragma mark 封装ReachabilityManager
-(void)test1{

  ReachabilityManager *rm = [ReachabilityManager share];
  [rm startListenNetworkLink];
  [rm setReachabilityStatusChangeBlock:^(ReachabilityNetworkType type) {
    NSString *typeStr = [NSString stringWithFormat:@"%ld",(long)type];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"网络发生变化" message:typeStr delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [av show];
  }];
  
  
}

@end
