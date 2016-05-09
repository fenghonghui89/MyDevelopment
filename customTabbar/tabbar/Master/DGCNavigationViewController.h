//
//  DGCNavigationViewController.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCBaseViewController.h"
#import "DGCTabBarItem.h"
@interface DGCNavigationViewController : DGCBaseViewController

@property(nonatomic,strong)DGCTabBarItem *tabBarItem;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)NSMutableArray *viewControllers;
@property(nonatomic,weak)DGCBaseViewController *selectedViewController;


-(id)initWithRootViewController:(DGCBaseViewController *)rootViewController;
- (void)pushViewController:(DGCBaseViewController *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToViewController:(DGCBaseViewController *)viewController animated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
@end


@interface DGCBaseViewController (DGCNavigationControllerItem)
@property(nonatomic,strong)DGCNavigationViewController *navigationController_t;

@end