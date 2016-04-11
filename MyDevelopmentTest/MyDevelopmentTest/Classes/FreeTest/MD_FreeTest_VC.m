//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_FreeTest_VC.h"

@interface MD_FreeTest_VC ()
{
  int tickets;
  int count;
  NSThread* ticketsThreadone;
  NSThread* ticketsThreadtwo;
  NSCondition* ticketsCondition;
}
@end

@implementation MD_FreeTest_VC
#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self tttest];
}

#pragma mark - < method > -

-(void)customInitUI{
  
  NSString *str = NSStringFromSelector(@selector(tttest));
  NSLog(@"%@",str);
}

-(void)tttest{
  
  tickets = 100;
  count = 0;
  
  // 锁对象
  ticketsCondition = [[NSCondition alloc] init];
  
  ticketsThreadone = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
  [ticketsThreadone setName:@"Thread-1"];
  [ticketsThreadone start];
  
  ticketsThreadtwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
  [ticketsThreadtwo setName:@"Thread-2"];
  [ticketsThreadtwo start];

  
}

- (void)run{
  
  while (YES) {
    [ticketsCondition lock];
    [NSThread sleepForTimeInterval:1];
    NSLog(@"%@ %d",[NSThread currentThread].name,tickets);
    tickets--;
    [ticketsCondition unlock];
  }
}
#pragma mark - < callback > -

@end
