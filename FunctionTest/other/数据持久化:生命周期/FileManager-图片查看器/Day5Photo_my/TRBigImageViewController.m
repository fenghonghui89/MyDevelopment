//
//  TRBigImageViewController.m
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-10.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRBigImageViewController.h"

@interface TRBigImageViewController ()<UIScrollViewDelegate>//1.遵守协议

@end

@implementation TRBigImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.album.imagePaths[self.index] lastPathComponent];//更改标题为图片路径的最后一部分
    
	//创建并设置scrollView
    UIScrollView* scrollView =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*self.album.imagePaths.count, 0);//内容宽度为图片数*屏幕宽度
    scrollView.contentOffset = CGPointMake(self.view.bounds.size.width*self.index, 0);//设置内容起点为所点击图片的坐标
    scrollView.backgroundColor = [UIColor whiteColor];//设置背景颜色
    scrollView.pagingEnabled =YES;//整页切换
    scrollView.delegate = self;//2.设置委托方的delegate为自己
    
    //把专辑中的每张图放进scrollView
    for (int i = 0; i<self.album.imagePaths.count; i++) {
        
        //创建并加入图片
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.image = [UIImage imageWithContentsOfFile:self.album.imagePaths[i]];
        
        [imageView setContentMode:UIViewContentModeScaleAspectFit];//修改填充方式
        
        [scrollView addSubview:imageView];
    }
    
    [self.view addSubview:scrollView];

}

//3.协议方法（切换图片后更改上面的标题为图片名字）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.view.bounds.size.width;//内容起点会随图片切换而改变
    NSLog(@"%f",scrollView.contentOffset.x);
    self.title = [[self.album.imagePaths objectAtIndex:index] lastPathComponent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
