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
}

#pragma mark - < action > -
- (IBAction)btnTap:(id)sender {
  self.student.age = 13;
  
}

- (IBAction)btn1Tap:(id)sender {
  [self willChangeValueForKey:@"student"];
  self.student.bag.brand = @"卡西欧";
  
  [self willChangeValueForKey:@"content"];
  self.content = @"hahaha~";
}

- (IBAction)btn2:(id)sender {
  [self didChangeValueForKey:@"student"];
  [self didChangeValueForKey:@"content"];
}

#pragma mark - < callback > -
+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
  DLog(@"key:%@",key);
  if ([key isEqualToString:@"content"] || [key isEqualToString:@"student"]) {
    return NO;
  }
  
  return [super automaticallyNotifiesObserversForKey:key];
}

@end
