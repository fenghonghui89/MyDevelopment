//
//  MDUIScrollView1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIScrollView1ViewController.h"

@interface MDUIScrollView1ViewController ()<UIScrollViewDelegate>
@property(retain,nonatomic)UIImageView* imageView;
@end

@implementation MDUIScrollView1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView* imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big.jpg"]];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, [[UIScreen mainScreen] bounds].size.height - 20)];
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
    
    //设置是否显示滚动条
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    
    //content与scrollview之间的距离（初始状态时不一定全部方向都有效果，拖动到边缘并停止后就会有效果）
    scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //"scroll"原点相对于content原点的偏移量，往右下滚为负（显示上面的内容），往左上滚为正（显示下面的内容）（初始状态下才有效果，可以用来判断scrollview滚动的位置）
    //    [scrollView setContentOffset:CGPointMake(50, 50) animated:YES];
    
    //滚动条与scrollview之间的距离
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(10,10,10,10);
  
    [self.view addSubview:scrollView];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//  NSLog(@"inset:%f,offset:%f",scrollView.contentInset.top,scrollView.contentOffset.y);
  NSLog(@"%f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//  NSLog(@"scrollview bound:%@",NSStringFromCGRect(scrollView.bounds));
}

@end
