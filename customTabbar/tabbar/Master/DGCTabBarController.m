//
//  DGCTabBarControllerNew.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCTabBarController.h"
#import "DGCDefine.h"
#import "DGCTool.h"
#import "DGCNavigationViewController.h"
@interface DGCTabBarController ()

@property(nonatomic,strong)NSArray *viewControllers;
@property(nonatomic,strong)DGCTabBar *tabBar;
@property(nonatomic,strong)DGCTabBarItem *selectedItem;
@property(nonatomic,strong)UIView* mainView;
@end

@implementation DGCTabBarController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self customInitUI];
  [self tabBar:self.tabBar didSelectItem:self.selectedItem];//默认第一个tab
}

- (id)initWithViewControllers:(NSArray *)viewControllers{
  
  self = [super init];
  if (self) {
    self.selectedIndex = -1;
    self.viewControllers = viewControllers;
  }
  return self;
}

#pragma mark - < method > -
#pragma mark custom init
-(void)customInitUI{
  
  [self customInitMainView];
  [self customInitTabBar];
}

-(void)customInitMainView{
  
  UIView *tmpMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH - tabBarH)];
  [self.view addSubview:tmpMainView];
  self.mainView = tmpMainView;
}

-(void)customInitTabBar{
  
  //提取tabBarItem
  NSMutableArray *tabBarItems = [NSMutableArray array];
  for (int i = 0;i < self.viewControllers.count ; i++) {
    DGCNavigationViewController *nvc = [self.viewControllers objectAtIndex:i];
    [tabBarItems addObject:nvc.tabBarItem];
    if (i == 0) {
      self.selectedItem = nvc.tabBarItem;
    }
  }
  
  //创建tabBar
  DGCTabBar *tabBar = [[DGCTabBar alloc] initWithOrgin:CGPointMake(0, viewH-tabBarH) items:tabBarItems];
  tabBar.delegate = self;
  [self.view addSubview:tabBar];
  self.tabBar = tabBar;
  
}


#pragma mark - < action > -
- (void)selectedTab:(NSInteger)index{
  
  DGCNavigationViewController *newShowNVC = [self.viewControllers objectAtIndex:index];
  [newShowNVC popToRootViewControllerAnimated:YES];
  
  [self.tabBar showItem:index];
  
  DGCTabBarItem *tabBarItem = [DGCTabBarItem new];
  tabBarItem.tag = index;
  
  [self tabBar:self.tabBar didSelectItem:tabBarItem];
}

#pragma mark - < callback > -
-(void)tabBar:(DGCTabBar *)tabBar willSelectItem:(DGCTabBarItem *)item callBack:(DGCMainViewBlock)block{
  block(NO);
}

-(void)tabBar:(DGCTabBar *)tabBar didSelectItem:(DGCTabBarItem *)item{
  
  NSInteger nextIndex = item.tag;
  
  if (nextIndex != self.selectedIndex) {
    
    //显示view
    DGCNavigationViewController *nextShowNVC = [self.viewControllers objectAtIndex:nextIndex];
    if ([self.mainView.subviews containsObject:nextShowNVC.view]) {
      [self.mainView bringSubviewToFront:nextShowNVC.view];
    }else{
      [self.mainView addSubview:nextShowNVC.view];
      nextShowNVC.view.frame = self.mainView.frame;
    }
    
    //修改标识
    self.selectedIndex = nextIndex;
  }
}


@end
