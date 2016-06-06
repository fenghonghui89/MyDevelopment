//
//  MD_UsefulPath_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UsefulPath_VC.h"

@interface MD_UsefulPath_VC ()

@end

@implementation MD_UsefulPath_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self test];
}

-(void)test{
  
  //沙盒根路径
  NSLog(@"home --- %@",NSHomeDirectory());
  
  //程序ID/Documents
  NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//注意是NSDocumentDirectory，不是NSDocumentnationDirectory
  NSString *docPath = [documentDirectory objectAtIndex:0];
  NSLog(@"docPath --- %@",docPath);
  
  //程序ID/Library/caches
  NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSLog(@"cachesPath --- %@",cachesPath);
  
  //程序ID/Library/preference
  NSString *preferencePath = [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSLog(@"preferencePath --- %@",preferencePath);
  
  //程序ID/tmp
  NSString *tmpDirectory = NSTemporaryDirectory();
  NSLog(@"tmpDirectory --- %@",tmpDirectory);
  
  //*.app的根路径
  NSString* appPath = [[NSBundle mainBundle]resourcePath];
  NSLog(@"appPath --- %@",appPath);
  
  NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
  NSLog(@"bundlePath --- %@",bundlePath);
  
  NSBundle *bundle = [NSBundle mainBundle];
  NSLog(@"bundle --- %@",bundle);
  
  //获取项目资源文件夹下某名称某类型的文件路径
  //注意，xib的话 type为nib不是xib
  NSString* picturePath = [[NSBundle mainBundle]pathForResource:@"picture" ofType:@"jpg"];
  NSLog(@"picturePath --- %@",picturePath);
  
  //bundleID
  NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
  NSLog(@"bundleID --- %@",bundleID);
  
  //包含各种信息的字典
  NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
  NSLog(@"infoDic --- %@",infoDic);
  
}

@end
