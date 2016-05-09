//
//  DGCTabBarControllerNew.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCBaseViewController.h"
#import "DGCTabBar.h"
#import "DGCTabBarItem.h"

@interface DGCTabBarController : DGCBaseViewController<DGCTabBarDelegate>
@property(nonatomic,assign) NSUInteger selectedIndex;
- (id)initWithViewControllers:(NSArray *)viewControllers;
- (void)selectedTab:(NSInteger)index;
@end
