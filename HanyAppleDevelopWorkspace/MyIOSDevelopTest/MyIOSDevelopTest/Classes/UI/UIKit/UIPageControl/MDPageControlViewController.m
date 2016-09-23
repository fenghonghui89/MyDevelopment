//
//  MDPageControlViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDPageControlViewController.h"
#import "MDTool.h"
@interface MDPageControlViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl* pageControl;
@property(nonatomic,strong)NSArray* imageNames;
@end

@implementation MDPageControlViewController

#pragma mark - vc lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customInitData];
    [self customInitUI];
}

-(void)customInitData
{
    self.imageNames = @[@"Shapes.jpg",@"Sky.jpg",@"Snow.jpg",@"Zebras.jpg"];
}

-(void)customInitUI
{
    //创建并修改scrollview的尺寸
    UIScrollView* scrollView = [UIScrollView new];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.delegate = self;
    scrollView.frame = self.view.frame;
    
    CGRect tempScrollViewframe = scrollView.frame;
    tempScrollViewframe.size.width *= self.imageNames.count;
    scrollView.contentSize = tempScrollViewframe.size;//修改contentSize的大小（也可以放进循环，每加一张图size也随之增大）
    
    //插入图片和按钮
    for (int i = 0 ; i<[self.imageNames count]; i++) {
        UIImageView* imageView;
        imageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageNames[i]]];
        
        //修改imageNamesView相对于scrollView的坐标
        //imageNamesView.frame = CGRectMake(x, 0, scroll.frame.size.width, scroll.frame.size.height);//方法1
        CGRect tempImageViewFrame = CGRectZero;//方法2
        tempImageViewFrame = scrollView.frame;//(最好不要=imageView.frame，不利于程序的维护)
        tempImageViewFrame.origin = CGPointMake(i*scrollView.frame.size.width, 0);
        imageView.frame = tempImageViewFrame;
        
        [scrollView addSubview:imageView];
        
        //用代码方式创建透明按钮
        if (i == self.imageNames.count - 1) {//0、1、2、3 最后一张图的下标=元素个数-1
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];//自定义按钮样式即为透明
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = tempImageViewFrame;
            NSLog(@"创建了按钮");
            [scrollView addSubview:button];
        }
    }
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    //创建小圆点
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageNames.count;
//    pageControl.userInteractionEnabled = NO;//取消小圆点与用户互动
    pageControl.frame = CGRectMake(0, [MDTool screenHeight]-[MDTool navigationBarHeight] - 40, [MDTool screenWidth], 20);
    [pageControl addTarget:self action:@selector(pageControlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

#pragma mark - action
-(void)tap:(id)sender
{
    NSLog(@".........");
}

-(void)pageControlValueChanged
{
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake([MDTool screenWidth]*whichPage, 0.0f);
    }];
}

#pragma mark - callback
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;//提取拖动时相对于contentsize的坐标（内容错位）
    NSLog(@"%.2f",offset.x);
    NSInteger index = round(offset.x/[MDTool screenWidth]);//四舍五入得出拖动时的下标
    self.pageControl.currentPage = index;
}
@end
