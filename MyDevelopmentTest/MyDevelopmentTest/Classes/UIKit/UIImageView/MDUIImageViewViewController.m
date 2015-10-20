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
    
    [self ivtest1];
}

#pragma mark - < test > -
#pragma mark 全屏缩放
-(void)ivtest1
{
    UIImage *image = [UIImage imageNamed:@"IMG_0309.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    //1.首先缩放为屏幕大小，但宽高比跟原来不一样（必须要这么做，否则contentMode没效果）
    imageView.frame = self.view.frame;
    
    //2.然后设置contentMode
//    imageView.contentMode = UIViewContentModeScaleToFill;//充满屏幕（系统默认）
//    imageView.contentMode = UIViewContentModeScaleAspectFill;//保持宽高比，充满屏幕，切除超出屏幕部分
    imageView.contentMode = UIViewContentModeScaleAspectFit;//缩放居中，保留全图，保持宽高比
}

#pragma mark 等比例缩放
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

#pragma mark 九切片
-(void)ivtest3
{
    //UIImageResizingModeStretch变化时拉伸
    UIImage* image1 = [UIImage imageNamed:@"tabbar_item_store.png"];
    UIImage* resizableImage1 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];//距离上左下右的边距，所形成的矩形为响应拉伸的范围
    
    UIImageView *iv1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, screenW, 30)];
    [self.view addSubview:iv1];
    iv1.image = resizableImage1;
    
    //UIImageResizingModeTile变化时复制
    UIImage* image2 = [UIImage imageNamed:@"tabbar_item_store.png"];
    UIImage* resizableImage2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, screenW, 30)];
    [self.view addSubview:iv2];
    iv2.image = resizableImage2;
    
    //例子
    UIImage* image3 = [UIImage imageNamed:@"bg94w100h.png"];
    UIImage* resizableImage3 = [image3 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 47, 0, 47) resizingMode:UIImageResizingModeTile];
    
    UIImageView *iv3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, screenW, 50)];
    [self.view addSubview:iv3];
    iv3.image = resizableImage3;
}

#pragma mark UIImage - drawAtPoint drawInRect drawAsPatternInRect
-(void)ivtest4
{
    MD_UIIV_CustomView *cv = [[MD_UIIV_CustomView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:cv];
}

#pragma mark UIImage - 动画
-(void)ivtest5
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 26)];
    iv.image = [UIImage animatedImageNamed:@"playing" duration:2.0];
    [self.view addSubview:iv];
}
@end
