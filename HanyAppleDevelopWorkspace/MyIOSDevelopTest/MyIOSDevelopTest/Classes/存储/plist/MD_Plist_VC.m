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

#pragma mark - base
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
  [newLevels writeToFile:@"/Users/hanyfeng/Desktop/test.plist" atomically:YES];
  
}

#pragma mark - NSPropertyListSerialization
-(void)test_write{

  
  NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
  [dataDictionary setValue:[NSNumber numberWithInt:222] forKey:@"intNumber"];
  [dataDictionary setValue:[NSArray arrayWithObjects:@"1",@"2", nil] forKey:@"testArray"];
  
  NSError *error;
  NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:dataDictionary
                                                               format:NSPropertyListXMLFormat_v1_0
                                                              options:0//该参数暂时未使用
                                                                error:&error];
  if(xmlData) {
    NSLog(@"No error creating XML data.");
    [xmlData writeToFile:@"/Users/hanyfeng/Desktop/test.plist" atomically:YES];
  }else{
    if (error) {
      NSLog(@"error:%@", error);
    }
  }
}

-(void)test_read{
  
  NSError *error;
  NSDictionary *dic = (NSDictionary *)[NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfFile:@"/Users/hanyfeng/Desktop/test.plist"]
                                                                                options:NSPropertyListImmutable
                                                                                 format:NULL
                                                                                  error:&error];
  NSLog(@"%@",dic);
}

@end
