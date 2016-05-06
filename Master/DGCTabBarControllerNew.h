//
//  DGCTabBarControllerNew.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "NKCViewController_Master.h"
#import "DGCTabBar.h"
#import "DGCTabBarItem.h"

@interface DGCTabBarControllerNew : NKCViewController_Master<DGCTabBarDelegate>

@property(nonatomic,assign) NSUInteger selectedIndex;
- (id)initWithViewControllers:(NSArray *)viewControllers;
- (void)selectedTab:(NSInteger)index;
@end
