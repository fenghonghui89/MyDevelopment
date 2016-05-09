//
//  DGCNavigationViewController.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCNavigationViewController.h"

@interface DGCNavigationViewController ()
@property(nonatomic,assign)CGRect subViewFrame;
@end

@implementation DGCNavigationViewController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.navigationBar.hidden = YES;
  self.addView.hidden = YES;
  self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
  self.selectedIndex = 0;
  [self.view addSubview:self.selectedViewController.view];
  self.subViewFrame = self.view.frame;
}

-(id)initWithRootViewController:(DGCBaseViewController *)rootViewController{

  self = [super init];
  if (self) {
    rootViewController.navigationController_t = self;
    self.viewControllers = [NSMutableArray arrayWithObjects:rootViewController, nil];
    self.selectedViewController = rootViewController;
  }
  return self;
}

#pragma mark - < method > -

#pragma mark - < action > -
#pragma mark push
- (void)pushViewController:(DGCBaseViewController *)viewController animated:(BOOL)animated{
  
  //定义blcok
  void(^animationBlock)(void) = ^(){
    viewController.view.frame = self.subViewFrame;
  };
  
  void(^completionBlock)(BOOL finished) = ^(BOOL finished){
    
    //触发自定义 vc lifecycle
    [viewController viewDidAppearCustom];
    [self.selectedViewController viewDidDisappearCustom];
    
    //修改数据源
    [self.viewControllers addObject:viewController];
    
    //修改标识
    self.selectedViewController = self.viewControllers.lastObject;
    self.selectedIndex = self.viewControllers.count - 1;
  };
  
  //执行
  viewController.mainViewController = self.mainViewController;
  viewController.navigationController_t = self;
  viewController.view.frame = CGRectMake(self.subViewFrame.size.width, self.subViewFrame.origin.y, self.subViewFrame.size.width, self.subViewFrame.size.height);
  [self.view addSubview:viewController.view];
  
  [viewController viewWillAppearCustom];
  [self.selectedViewController viewWillDisappearCustom];
  
  if (animated) {
    [UIView animateWithDuration:0.25
                          delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:animationBlock
                     completion:completionBlock];
  }else{
    completionBlock(YES);
  }
  
}

#pragma mark pop
- (void)popViewControllerAnimated:(BOOL)animated{
  
  if (self.viewControllers.count <= 1) {
    return;
  }
  
  //--- 定义blcok
  //上一个vc
  DGCBaseViewController *previousViewController = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
  
  void(^animationBlock)(void) = ^(){
    self.selectedViewController.view.frame = CGRectMake(self.subViewFrame.size.width, self.subViewFrame.origin.y, self.subViewFrame.size.width, self.subViewFrame.size.height);
  };
  
  void(^completionBlock)(BOOL finished) = ^(BOOL finished){
    
    //触发自定义 vc lifecycle
    [previousViewController viewDidAppearCustom];
    [self.selectedViewController viewDidDisappearCustom];
    
    //修改数据源
    [self.selectedViewController.view removeFromSuperview];
    [self.viewControllers removeLastObject];
    
    //修改标识
    self.selectedViewController = self.viewControllers.lastObject;
    self.selectedIndex = self.viewControllers.count - 1;
  };
  
  //--- 执行
  [previousViewController viewWillAppearCustom];
  [self.selectedViewController viewWillDisappearCustom];
  if (animated) {
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:animationBlock
                     completion:completionBlock];
  }else{
    completionBlock(YES);
  }
}

- (void)popToViewController:(DGCBaseViewController *)viewController animated:(BOOL)animated{
  
  NSInteger index = [self.viewControllers indexOfObject:viewController];
  if (index == NSNotFound) {
    return;
  }
  
  if (viewController == self.selectedViewController) {
    return;
  }
  
  if (self.viewControllers.count <= 1) {
    return;
  }else if (self.viewControllers.count == 2) {
    [self popViewControllerAnimated:animated];
  }else{
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:[self.viewControllers subarrayWithRange:NSMakeRange(0, index+1)]];//起始位置，个数
    for (int i = 0 ; i<self.viewControllers.count; i++) {
      DGCBaseViewController *vc = [self.viewControllers objectAtIndex:i];
      if (i <= index || self.viewControllers.count - 1 == i) {
        [vcs addObject:vc];
      }else{
        [vc.view removeFromSuperview];
      }
    }
    self.viewControllers = vcs;
    [self popViewControllerAnimated:animated];
  }
  
}

- (void)popToRootViewControllerAnimated:(BOOL)animated{
  
  if (self.viewControllers.count == 1) {
    return;
  }else{
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i<self.viewControllers.count; i++) {
      DGCBaseViewController *vc = [self.viewControllers objectAtIndex:i];
      if (i == 0 || self.viewControllers.count - 1 == i) {
        [vcs addObject:vc];
      }else{
        [vc.view removeFromSuperview];
      }
    }
    self.viewControllers = vcs;
    [self popViewControllerAnimated:animated];
  }
}
#pragma mark - < callback > -


@end
