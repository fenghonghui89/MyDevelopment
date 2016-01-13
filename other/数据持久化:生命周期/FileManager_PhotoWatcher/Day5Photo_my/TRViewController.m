//
//  TRViewController.m
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRBigImageViewController.h"
@interface TRViewController ()
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建scrollView
    UIScrollView* scrollView =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    //设置ContentSize大小
    int count = self.album.imagePaths.count;
    float height = (count%4 == 0? count/4*80:(count/4+2)*80);//设置contentSize高度(判断有没有不够排成一排的，有的话要输出多少)
    scrollView.contentSize = CGSizeMake(0, height);
    //[sv setContentSize:CGSizeMake(0, height)];//设置ContentSize方法
    
    //把专辑中的每张图放进scrollView
    for (int i = 0; i<self.album.imagePaths.count; i++) {
        
        //创建并加入图片
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%4*80, i/4*80, 80, 80)];
        imageView.image = [UIImage imageWithContentsOfFile:self.album.imagePaths[i]];
        
        //修改填充方式
        [imageView setContentMode:UIViewContentModeScaleAspectFill];//AspectFill要与clipsToBounds一起用，否则重叠
        imageView.clipsToBounds = YES;
        
        imageView.layer.borderWidth = 2;//添加边框
        imageView.layer.cornerRadius = 4;//添加圆角（所有view都能用，值越大越圆）
        imageView.userInteractionEnabled = YES;//开启手势识别
        imageView.tag = i;//把数组下标赋值给每张图片的tag
        
        //添加点击手势识别器到每张图片当中
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [scrollView addSubview:imageView];
    }
    
    [self.view addSubview:scrollView];
    
}

//点击图片转到大图页面
-(void)tapAction:(UITapGestureRecognizer*)sender
{
    
//    UIImage* image = sender.view;
//    UIImageView* iv = [[UIImageView alloc] initWithImage:image];
    UIImageView* iv = (UIImageView*)sender.view;//识别器被加入到什么当中，识别器.view就是什么(上面的会崩溃)
    
    TRBigImageViewController* bivc = [TRBigImageViewController new];
    bivc.album = self.album;
    bivc.index = iv.tag;
    [self.navigationController pushViewController:bivc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
