//
//  MD_Plist_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Plist_VC.h"

@interface MD_Plist_VC ()

@end

@implementation MD_Plist_VC

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self test];
}

-(void)test{
  
  //把plist文件 转为数组
  NSString *namesPath = [[NSBundle mainBundle]pathForResource:@"my" ofType:@"plist"];
  NSArray *names = [NSArray arrayWithContentsOfFile:namesPath];
  
  for (NSString *name in names) {
    NSLog(@"%@",name);
  }
  
  //把plist 转为字典
  NSString *levelsPath = [[NSBundle mainBundle]pathForResource:@"leves" ofType:@"plist"];
  NSDictionary *levels = [NSDictionary dictionaryWithContentsOfFile:levelsPath];
  NSLog(@"第2关敌人数量%@",[levels objectForKey:@"level2"]);
  
  //把数组转为plist文件
  NSArray *newNames = @[@"哈哈",@"嘿嘿",@"呵呵"];
  [newNames writeToFile:@"/Users/apple/Desktop/newNames.plist" atomically:YES];
  
  //字典保存为plist文件
  NSNumber* num1 = [NSNumber numberWithInt:1];
  NSNumber* num2 = [NSNumber numberWithInt:2];
  NSNumber* num3 = [NSNumber numberWithInt:3];
  
  NSDictionary* newLevels = [NSDictionary dictionaryWithObjectsAndKeys:num1,@"one",num2,@"two",num3,@"three", nil];
  [newLevels writeToFile:@"/Users/apple/Desktop/newLevels.plist" atomically:YES];
  
}


@end
