//
//  TRViewController.m
//  Day15GetImagePath_my
//
//  Created by HanyFeng on 13-12-24.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //黄色文件夹：图片会直接存放到bundle根目录（*.app）下面
	NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"yangmi01" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    NSLog(@"imagePath：%@",imagePath);
    NSLog(@"data.length：%d",data.length);
    
    //蓝色文件夹：会创建一个文件夹存放图片，而不是直接放在根目录下，所以要加文件夹名称
    UIImage *image = [UIImage imageNamed:@"杨幂副本/yangmi01.jpg"];
    NSLog(@"width = %f",image.size.width);
    
    NSString *mainPath = [[NSBundle mainBundle]resourcePath];
    NSLog(@"mainPath:%@",mainPath);
    mainPath = [mainPath stringByAppendingPathComponent:@"杨幂副本"];//蓝色文件夹的话要拼接文件夹名称，黄色则不用
    NSArray *fileNames = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:mainPath error:nil];
    
    //获取所有图片的路径并输出
    NSMutableArray *imagePaths = [NSMutableArray array];
    for (NSString *fileName in fileNames) {
        if ([fileName hasSuffix:@"jpg"]) {
            NSString *imagePath = [mainPath stringByAppendingPathComponent:fileName];
            [imagePaths addObject:imagePath];
        }
    }
    NSLog(@"\nimagePaths：\n%@",imagePaths);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
