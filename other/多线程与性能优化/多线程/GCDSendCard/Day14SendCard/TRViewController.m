//
//  TRViewController.m
//  Day14SendCard
//
//  Created by Tarena on 13-12-19.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadCards];
}

-(void)loadCards{
    //用文件管理器取得文件夹下所有图片名称
    NSString *directoryPath = @"/Users/hanyfeng/Desktop/杂/photo/未命名文件夹";
    NSArray *fileNames = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:directoryPath error:nil];
    
    //把图片加载到界面当中并显示
    for (int i=0;i<fileNames.count;i++) {
        NSString *fileName = fileNames[i];
        if ([fileName hasPrefix:@"."]) {//排除隐藏文件（以.开头）
            continue;
        }
        NSString *imagePath = [directoryPath stringByAppendingPathComponent:fileName];//把图片名称和文件夹路径拼接为图片路径
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(150+i*10, 150, 60, 90)];
        iv.layer.borderWidth = 2;//边框宽度
        iv.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色
        iv.image = [UIImage imageWithContentsOfFile:imagePath];
        [self.view addSubview:iv];
    }
}

- (IBAction)clicked:(id)sender {
    
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", nil);//新建自定义队列
    
    for (int i=self.view.subviews.count-1; i>=0; i--) {//遍历self.view所有的子View（除去按钮）
        UIView *subView = [self.view.subviews objectAtIndex:i];
        if ([subView isMemberOfClass:[UIImageView class]]) {//如果子View是图片，开启子线程
            dispatch_async(myQueue, ^{
                [NSThread sleepForTimeInterval:.4];
                //回到主线程更新界面
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:.5 animations:^{//在指定显示间隔内显示动画
                    [self.view bringSubviewToFront:subView];//把子View放到最前端显示
                        subView.center = CGPointMake(20+15*(self.view.subviews.count-i), 100);
                    }];
                });

            });
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
