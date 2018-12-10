//
//  DGCTabBarControllerNew.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//


#import "DGCTabBar.h"
#import "DGCTabBarItem.h"

@interface DGCTabBarController : UIViewController<DGCTabBarDelegate>
@property(nonatomic,assign) NSUInteger selectedIndex;
- (id)initWithViewControllers:(NSArray *)viewControllers;
- (void)selectedTab:(NSInteger)index;
-(void)hideTabBarWithAnimation:(BOOL)animation;
-(void)showTabBarWithAnimation:(BOOL)animation;
@end
