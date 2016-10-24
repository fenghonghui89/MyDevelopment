//
//  MDUIScrollView4ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIScrollView4ViewController.h"

@interface MDUIScrollView4ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation MDUIScrollView4ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImage *image = [UIImage imageNamed:@"000.jpg"];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
  [imageView setUserInteractionEnabled:YES];
  
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
  scrollView.contentSize = CGSizeMake(imageView.frame.size.width,imageView.frame.size.height);
  scrollView.delegate = self;
  [scrollView addSubview:imageView];
  self.imageView = imageView;
  [self.view addSubview:scrollView];
  self.scrollView = scrollView;
  
  //设置最大最小缩放比例（计算scrollView与imageView1的宽高比，最小缩放比例取最小值，最大缩放比例取原图大小）
  float horizontalScale = self.view.frame.size.width / imageView.frame.size.width;//宽
  float verticalScale = self.view.frame.size.height / imageView.frame.size.height;//高
  scrollView.minimumZoomScale = MIN(horizontalScale, verticalScale);
  scrollView.maximumZoomScale = 2.0;
  
  [scrollView scrollRectToVisible:CGRectMake(0, 0, imageView.frame.size.width/2, imageView.frame.size.height/2) animated:YES];
}



#pragma mark - scrollView协议
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
  UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
  [tgr setNumberOfTapsRequired:2];
  [self.imageView addGestureRecognizer:tgr];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.imageView;
}

//双击事件
-(void)tap:(UITapGestureRecognizer *)sender
{
  [self.scrollView setZoomScale:1.0];
  [self.imageView removeGestureRecognizer:sender];
}

@end
