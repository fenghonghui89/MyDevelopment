//
//  MD_KeyedArchiver_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_KeyedArchiver_VC.h"
#import "TRPerson.h"
#import "TRBook.h"
@interface MD_KeyedArchiver_VC ()

@end

@implementation MD_KeyedArchiver_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
}


- (IBAction)archBtnTap:(id)sender {
  
  //准备要归档的对象（该对象遵守NSCoding协议）
  TRPerson *p = [TRPerson testData];
  
  //创建一个归档的对象
  NSMutableData *data = [NSMutableData data];
  NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
  [arch encodeObject:p forKey:@"person"];
  
  //完成编码
  [arch finishEncoding];
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/person"];
  NSError *error = nil;
  [data writeToFile:path options:NSDataWritingAtomic error:&error];
  if (error) {
    DRLog(@"arch error..%@",error.localizedDescription);
  }else{
    DRLog(@"finish..path:%@ length:%ld",path,(unsigned long)data.length);
  }
}

- (IBAction)unarchBtnTap:(id)sender {
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/person"];
  NSError *error = nil;
  NSData *personData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&error];
  if (error) {
    DRLog(@"unarch error..%@",error.localizedDescription);
  }else{
    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:personData];
    TRPerson *unp = [unArch decodeObjectForKey:@"person"];
    [unArch finishDecoding];
    
    TRBook *book = [unp.books objectAtIndex:0];
    DRLog(@"person..name:%@ age:%ld book:%@",unp.name,(long)unp.age,book.name);
  }

}

@end
