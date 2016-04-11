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

#pragma mark - < method > -
-(void)customInitUI{

  [NSThread detachNewThreadSelector:@selector(createMouse) toTarget:self withObject:nil];
}

-(void)createMouse{

//  [NSThread sleepForTimeInterval:1];
//  
//  CGFloat w = 20;
//  CGFloat h = 20;
//  CGFloat x = arc4random()%((NSInteger)(viewW-20));
//  CGFloat y  = arc4random()%((NSInteger)(viewH-20));
//  MDMouse *mouse = [[MDMouse alloc] initWithFrame:CGRectMake(x, y, w, h)];
//
//  [self performSelectorOnMainThread:@selector(addToView:) withObject:mouse waitUntilDone:NO];
//  
//  [self createMouse];
  
  
  while (YES) {
    [NSThread sleepForTimeInterval:1];
    
    CGFloat w = 20;
    CGFloat h = 20;
    CGFloat x = arc4random()%((NSInteger)(viewW-20));
    CGFloat y  = arc4random()%((NSInteger)(viewH-20));
    MDMouse *mouse = [[MDMouse alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    [self performSelectorOnMainThread:@selector(addToView:) withObject:mouse waitUntilDone:NO];
  }
}

-(void)addToView:(MDMouse *)mouse{

  [self.view addSubview:mouse];
}
@end
