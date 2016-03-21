//
//  MDKVO_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
#import "MDKVO_View.h"
#import "MDKVO_VC.h"
#import "MDStudent.h"
#import "MDBag.h"



@interface MDKVO_VC ()
@property (weak, nonatomic) IBOutlet MDKVO_View *kvo_view;
@property(nonatomic,strong)MDStudent *student;
@property(nonatomic,copy)NSString *content;
@end

@implementation MDKVO_VC

#pragma mark - < vc lifecycle > -
-(void)dealloc{
  [self removeObserver:self.kvo_view forKeyPath:@"student"];
  [self removeObserver:self.kvo_view forKeyPath:@"content"];
  
//  [self removeObserver:self.kvo_view forKeyPath:studentContext];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  MDStudent *studnet = [[MDStudent alloc] init];
  studnet.age = 12;
  studnet.name = @"张三";
  studnet.bag = [[MDBag alloc] init];
  studnet.bag.brand = @"瑞士军刀";
  studnet.bag.model = 1234;
  self.student = studnet;
  [self addObserver:self.kvo_view forKeyPath:@"student" options:NSKeyValueObservingOptionNew context:@"student发生变化"];
  [self addObserver:self.kvo_view forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:@"content发生变化"];
  
  //或者
//  [self addObserver:self.kvo_view forKeyPath:@"student" options:NSKeyValueObservingOptionNew context:studentContext];
//  [self addObserver:self.kvo_view forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:contentContext];
  
  //观察view的frame的例子
//  [self.moveView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - < action > -
- (IBAction)btnTap:(id)sender {
  self.student.age = 13;
  
}

//开始改变
- (IBAction)btn1Tap:(id)sender {
  [self willChangeValueForKey:@"student"];
  self.student.bag.brand = @"卡西欧";
  
  [self willChangeValueForKey:@"content"];
  self.content = @"hahaha~";
}

//结束改变
- (IBAction)btn2:(id)sender {
  [self didChangeValueForKey:@"student"];
  [self didChangeValueForKey:@"content"];
}

#pragma mark - < callback > -
//如果需要手动控制通知触发，则需要重新该回调
+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
  DLog(@"key:%@",key);
  if ([key isEqualToString:@"content"] || [key isEqualToString:@"student"]) {
    return NO;
  }
  
  return [super automaticallyNotifiesObserversForKey:key];
}

@end
