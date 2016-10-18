//
//  MD_KeyedArchiver_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_KeyedArchiver_VC.h"
#import "MD_Model3.h"
@interface MD_KeyedArchiver_VC ()

@end

@implementation MD_KeyedArchiver_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

//归档
- (IBAction)archBtnTap:(id)sender {
  
  //详细方法
//  //准备要归档的对象（该对象遵守NSCoding协议）
//  TRPerson *person = [TRPerson testData];
//  
//  //归档对象
//  NSMutableData *data = [NSMutableData data];
//  NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//  [arch encodeObject:person forKey:@"person"];
//  [arch finishEncoding];
//  
//  //保存到本地
//  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//  path = [path stringByAppendingString:@"/person"];
//  NSError *error = nil;
//  [data writeToFile:path options:NSDataWritingAtomic error:&error];
//  if (error) {
//    DRLog(@"arch error..%@",error.localizedDescription);
//  }else{
//    DRLog(@"finish..path:%@ length:%ld",path,(unsigned long)data.length);
//  }
  
  
  //简便方法
  TRPerson *person = [TRPerson testData];
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/person"];
  
  BOOL b = [NSKeyedArchiver archiveRootObject:person toFile:path];
  if (b) {
    DRLog(@"finish..path:%@",path);
  }else{
    DRLog(@"arch error..%@",@"error...");
  }
  
}

//反归档
- (IBAction)unarchBtnTap:(id)sender {
  
  //详细方法
//  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//  path = [path stringByAppendingString:@"/person"];
//  NSError *error = nil;
//  NSData *personData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&error];
//  if (error) {
//    DRLog(@"unarch error..%@",error.localizedDescription);
//  }else{
//    
//    TRPerson *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    TRBook *book = [person.books objectForKey:@"book2"];
//    DRLog(@"person..name:%@ age:%ld book:%@",person.name,(long)person.age,book.name);
//  }
  
  //简便方法
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingString:@"/person"];
  
  TRPerson *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  if (person != nil) {
    TRBook *book = [person.books objectForKey:@"book2"];
    DRLog(@"person..name:%@ age:%ld book:%@",person.name,(long)person.age,book.name);
  }else{
    DRLog(@"error...no file");
  }
  
}

@end
