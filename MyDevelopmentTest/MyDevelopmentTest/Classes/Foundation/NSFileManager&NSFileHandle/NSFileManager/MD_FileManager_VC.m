//
//  MD_FileManager_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_FileManager_VC.h"

@interface MD_FileManager_VC ()

@end

@implementation MD_FileManager_VC

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSFileManager* fm = [NSFileManager defaultManager];//得到文件管理器
  NSString* dircetoryPath = @"/Users/apple/Desktop/img副本";
  NSArray* fileNames = [fm contentsOfDirectoryAtPath:dircetoryPath error:nil];//获取文件夹下面所有文件的名称，并用数组存储
  
  //把文件路径逐一存进数组
  NSMutableArray* imagePaths = [NSMutableArray array];
  for (NSString* fileName in fileNames) {
    NSString* imagePath = [dircetoryPath stringByAppendingPathComponent:fileName];//把文件夹路径和文件名称拼接成文件路径
    NSLog(@"%@",imagePath);
    
    if ([fileName isEqualToString:@"bullet_1.png"]) {
      [fm removeItemAtPath:imagePath error:nil];//删除文件
      continue;//跳出当次循环
    }
    
    [imagePaths addObject:imagePath];
  }
  
  //把图片逐一显示出来
  for (int i = 0; i<imagePaths.count; i++) {
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%4*80, i/4*80, 80, 80)];
    UIImage* image = [UIImage imageWithContentsOfFile:imagePaths[i]];
    imageView.image = image;
    [self.view addSubview:imageView];
  }
  
  //创建文件
  NSString* newFilePath = @"/Users/apple/Desktop/aaaa.txt";
  NSData* data = [@"嘿嘿 哈哈 呵呵" dataUsingEncoding:NSUTF8StringEncoding];
  [fm createFileAtPath:newFilePath contents:data attributes:nil];
  
  //复制文件
  NSString* filePath = @"/Users/apple/Desktop/aaaa.txt";
  NSString* fileToPath = @"/Users/apple/Desktop/bbbb.txt";
  [fm copyItemAtPath:filePath toPath:fileToPath error:nil];
  
  //判断文件是否存在
  if ([fm fileExistsAtPath:filePath]) {
    NSLog(@"文件存在");
  }
  
  //判断是否是文件夹
  BOOL isDirectory;
  if ([fm fileExistsAtPath:@"/Users/apple/Desktop/img2" isDirectory:&isDirectory] && isDirectory) {
    //        if (isDirectory) {
    NSLog(@"是文件夹");
    //        }
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)findFileInDirecotryPath:(NSString *)path
{
  //得到文件管理器
  NSFileManager* fm = [NSFileManager defaultManager];
  //得到文件夹下所有文件的名称
  NSArray* fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
  
  for (NSString* fileName in fileNames) {
    NSString* filePath = [path stringByAppendingPathComponent:fileName];//得到文件的完整路径
    
    BOOL isDirectory;
    if ([fm fileExistsAtPath:filePath isDirectory:&isDirectory] && isDirectory) {//如果是文件夹，则递归方法
      [self findFileInDirecotryPath:filePath];
    }else {//如果是文件，则判断后缀，类型符合就复制到文件夹下
      if ([fileName hasSuffix:@"jpg"]) {
        NSString* newDirectoryPath = @"/Users/apple/Desktop/未命名文件夹 2";
        NSString* newFilePath = [newDirectoryPath stringByAppendingPathComponent:fileName];
        [fm copyItemAtPath:filePath toPath:newFilePath error:nil];
      }
    }
  }
}


@end