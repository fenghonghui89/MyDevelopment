//
//  TRViewController.m
//  Day4FileManager_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFileManager* fm = [NSFileManager defaultManager];//得到文件管理器
    NSString* dircetoryPath = @"/Users/apple/Desktop/img2";
    NSArray* imageNames = [fm contentsOfDirectoryAtPath:dircetoryPath error:nil];//获取文件夹下面所有文件的名称，并用数组存储
    
    //把文件路径逐一存进数组
    NSMutableArray* imagePaths = [NSMutableArray array];
    for (NSString* imageName in imageNames) {
        NSString* imagePath = [dircetoryPath stringByAppendingPathComponent:imageName];//把文件夹路径和文件名称拼接成文件路径
        NSLog(@"%@",imagePath);
        [imagePaths addObject:imagePath];
    }
    
    //把图片逐一显示出来
    for (int i = 0; i<imagePaths.count; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%4*80, i/4*80, 80, 80)];
        UIImage* image = [UIImage imageWithContentsOfFile:imagePaths[i]];
        imageView.image = image;
        [self.view addSubview:imageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
