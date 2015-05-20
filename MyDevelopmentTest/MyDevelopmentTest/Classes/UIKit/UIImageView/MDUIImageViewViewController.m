//
//  MDUIImageViewViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIImageViewViewController.h"

@interface MDUIImageViewViewController ()

@end

@implementation MDUIImageViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"small.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    //1.首先缩放为屏幕大小，但宽高比跟原来不一样（必须要这么做，否则contentMode没效果）
    imageView.frame = self.view.frame;
    
    //2.然后设置contentMode
//    imageView.contentMode = UIViewContentModeScaleToFill;//充满屏幕（系统默认）
//    imageView.contentMode = UIViewContentModeScaleAspectFill;//充满屏幕，切除超出屏幕部分
    imageView.contentMode = UIViewContentModeScaleAspectFit;//缩放居中，保留全图，保持宽高比
}


@end
