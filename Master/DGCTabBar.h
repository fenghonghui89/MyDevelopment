//
//  DGCTabBar.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGCDefine.h"
typedef void(^DGCMainViewBlock)(BOOL isSuccess);


@class DGCTabBarItem,DGCTabBar;

@protocol DGCTabBarDelegate <NSObject>

@optional
- (void)tabBar:(DGCTabBar *)tabBar willSelectItem:(DGCTabBarItem *)item  callBack:(DGCMainViewBlock)block;
- (void)tabBar:(DGCTabBar *)tabBar didSelectItem:(DGCTabBarItem *)item;


@end

@interface DGCTabBar : UIView
@property(nonatomic,weak)id<DGCTabBarDelegate> delegate;
@property(nonatomic,weak)DGCTabBarItem *selectedItem;

- (id)initWithOrgin:(CGPoint)orgin items:(NSArray *)items;
- (void)showItem:(NSInteger)index;
@end
