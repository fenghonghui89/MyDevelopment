//
//  MDUIScrollView3ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIScrollView3ViewController.h"

@interface MDUIScrollView3ViewController ()<UIScrollViewDelegate>
@property(retain,nonatomic)UIImageView* imageView;
@end

@implementation MDUIScrollView3ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
  UIImageView* imageView1 = [[UIImageView alloc] init];
  [imageView1 setBackgroundColor: [UIColor blueColor]];
  self.imageView = imageView1;
  
  UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
  scrollView.contentSize = imageView1.frame.size;
  [scrollView setBackgroundColor:[UIColor redColor]];
  scrollView.delegate = self;
  [scrollView addSubview:imageView1];
  self.imageView = imageView1;
  
  //设置最大最小缩放比例（计算scrollView与imageView1的宽高比，最小缩放比例取最小值，最大缩放比例取原图大小）
  float horizontalScale = scrollView.frame.size.width / imageView1.frame.size.width;//宽
  float verticalScale = scrollView.frame.size.height / imageView1.frame.size.height;//高
  scrollView.minimumZoomScale = MIN(horizontalScale, verticalScale);
  scrollView.maximumZoomScale = 1.0;
  NSLog(@"min:%f max:%f",scrollView.minimumZoomScale,scrollView.maximumZoomScale);
  scrollView.zoomScale = 0.1;
  
  //设置缩放后拖动浏览图片时是否显示滚动条
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = YES;
  
  [self.view addSubview:scrollView];
  [self doimg];
}

-(void)doimg
{
  [self.imageView setImage:[UIImage imageNamed:@"big.jpg"]];
}

#pragma mark - UIScrollViewDelegate 协议方法 以下方法缩放时调用-
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  NSLog(@"1");
  return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
  NSLog(@"2");
}

@end
