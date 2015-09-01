//
//  MDUIImageViewViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIImageViewViewController.h"
#import "MD_UIIV_CustomView.h"
@interface MDUIImageViewViewController ()

@end

@implementation MDUIImageViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self uiimagetest];
}

//全屏缩放
-(void)ivtest1
{
    UIImage *image = [UIImage imageNamed:@"small.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    //1.首先缩放为屏幕大小，但宽高比跟原来不一样（必须要这么做，否则contentMode没效果）
    imageView.frame = self.view.frame;
    
    //2.然后设置contentMode
//    imageView.contentMode = UIViewContentModeScaleToFill;//充满屏幕（系统默认）
//    imageView.contentMode = UIViewContentModeScaleAspectFill;//保持宽高比，充满屏幕，切除超出屏幕部分
    imageView.contentMode = UIViewContentModeScaleAspectFit;//缩放居中，保留全图，保持宽高比
}

//等比例缩放
-(void)ivtest2
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 300)];
    [iv setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:iv];
    
    UIImage *i = [UIImage imageNamed:@"big1.jpg"];
    iv.image = i;

    [iv setContentMode:UIViewContentModeScaleAspectFill];
    [iv setClipsToBounds:YES];
}

//九切片
-(void)ivtest3
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, screenW, 50)];
    [self.view addSubview:iv];
    
    UIImage* image3 = [UIImage imageNamed:@"bg94w100h.png"];
    UIImage* resizableImage3 = [image3 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 47, 0, 47) resizingMode:UIImageResizingModeStretch];
    iv.image = resizableImage3;
}

-(void)uiimagetest
{
    MD_UIIV_CustomView *cv = [[MD_UIIV_CustomView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:cv];
}
@end
