//
//  MD_NSThread_Game_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSThread_Game_VC.h"
#import "MDMouse.h"
@interface MD_NSThread_Game_VC ()
@property(nonatomic,strong)NSThread *thread;
@end
@implementation MD_NSThread_Game_VC

#pragma mark - < vc lifecycle > -
-(void)viewDidLoad{
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self customInitUI];
}

-(void)viewDidDisappear:(BOOL)animated{
  
  //注意此时的currentThread不是self.thread
//  NSThread *thread = [NSThread currentThread];
//  
//  if ([thread isEqual:self.thread]) {
//    [[NSThread currentThread] cancel];
//  }
  
  [self.thread cancel];
  
  [super viewDidDisappear:animated];
}

#pragma mark - < method > -
-(void)customInitUI{
  
  NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createMouse) object:nil];
  thread.name = @"createMouse";
  [thread start];
  self.thread = thread;
}

-(void)createMouse{
  
  while (YES) {

    //此时的currentThread是self.thread
    if ([self.thread isCancelled]) {
      [NSThread exit];//或者return
    }
    
    [NSThread sleepForTimeInterval:0.5];
    
    CGFloat w = 30;
    CGFloat h = 30;
    CGFloat x = arc4random()%((NSInteger)(viewW-30));
    CGFloat y  = arc4random()%((NSInteger)(viewH-30));
    MDMouse *mouse = [[MDMouse alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    [self performSelectorOnMainThread:@selector(addToView:) withObject:mouse waitUntilDone:NO];
  }
}

-(void)addToView:(MDMouse *)mouse{
  
  [self.view addSubview:mouse];
}
@end
