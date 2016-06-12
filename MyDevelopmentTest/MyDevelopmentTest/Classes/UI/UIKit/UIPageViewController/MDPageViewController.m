//
//  MDPageViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDPageViewController.h"
#import "MDPage1ViewController.h"
#import "MDPage2ViewController.h"
#import "MDPage3ViewController.h"

@interface MDPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)UIPageViewController *pageViewController;
@property(nonatomic,strong)NSArray *viewControllers;
@end

@implementation MDPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIViewController *page1ViewController = [MDPage1ViewController new];
    UIViewController *page2ViewController = [MDPage2ViewController new];
    UIViewController *page3ViewController = [MDPage3ViewController new];
    NSArray *viewControllers = @[page1ViewController,page2ViewController,page3ViewController];
    self.viewControllers = viewControllers;
    self.pageIndex = 0;
    
    
    
    //翻页效果；翻页方向
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //取出第一个视图控制器，作为PageViewController首页（受书脊位置影响）
    NSArray *firstViewControllers = @[page1ViewController];
    [self.pageViewController setViewControllers:firstViewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark - Page View Controller Data Source
//上一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    self.pageIndex--;
    
    if (self.pageIndex < 0){
        self.pageIndex = 0;
        return nil;
    }
    
    UIViewController *vc = self.viewControllers[self.pageIndex];
    
    return vc;
    
}

//下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    self.pageIndex++;
    
    if (self.pageIndex > 2){
        self.pageIndex = 2;
        return nil;
    }
    
    UIViewController *vc = self.viewControllers[self.pageIndex];
    
    return vc;
}

#pragma mark - Page View Controller Delegate
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;//影响首页显示的视图个数
}

@end
