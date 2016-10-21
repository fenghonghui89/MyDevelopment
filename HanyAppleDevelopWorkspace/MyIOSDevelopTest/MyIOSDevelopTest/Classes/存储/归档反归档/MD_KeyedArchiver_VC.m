//
//  MD_KeyedArchiver_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 如果a对象的父类实现了NSCoding协议，只要NSCoding协议通用，则子类不用实现
 如果a对象有属性是自定义类型 或者是“元素是自定义类型”的容器类型 则自定义类型也要实现NSCoding，否则个别属性无法存储
 */

#import "MD_KeyedArchiver_VC.h"
#import "MD_Model3.h"
#import "YYModel.h"
@interface MD_KeyedArchiver_VC ()

@end

@implementation MD_KeyedArchiver_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

//归档
- (IBAction)archBtnTap:(id)sender {
  
  //完整方法
//  TRMidStudent *student = [[TRMidStudent testData] objectAtIndex:0];
//  
//  NSMutableData *data = [NSMutableData data];
//  NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//  [arch encodeObject:student forKey:@"student"];
//  [arch finishEncoding];
//  
//  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//  path = [path stringByAppendingString:@"/student"];
//  NSError *error = nil;
//  [data writeToFile:path options:NSDataWritingAtomic error:&error];
//  if (!error) {
//    DRLog(@"finish..path:%@",path);
//  }else{
//    DRLog(@"arch error..%@",error.localizedDescription);
//  }
  
  //简便方法
  TRMidStudent *student = [[TRMidStudent testData] objectAtIndex:0];
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/student"];
  BOOL b = [NSKeyedArchiver archiveRootObject:student toFile:path];
  if (b) {
    DRLog(@"finish..path:%@",path);
  }else{
    DRLog(@"arch error..");
  }
  
}

//反归档
- (IBAction)unarchBtnTap:(id)sender {
  
  //完整方法
//  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//  path = [path stringByAppendingString:@"/student"];
//  
//  NSError *error = nil;
//  NSData *personData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&error];
//  NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:personData];
//  TRMidStudent *student = [unarch decodeObjectForKey:@"student"];
//  if (student != nil) {
//    DRLog(@"student..%@",student);
//  }else{
//    DRLog(@"error...no file");
//  }
  
  //简便方法
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/student"];
  TRMidStudent *student = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  if (student != nil) {
    DRLog(@"student..%@",student);
  }else{
    DRLog(@"error...no file");
  }
  
}

//删除文件
- (IBAction)deleteBtnTap:(id)sender {
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/student"];
  
  NSError *error;
  [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
  if (error) {
    DRLog(@"rm error..%@",error.localizedDescription);
  }else{
    DRLog(@"rm success..");
  }
}


@end
