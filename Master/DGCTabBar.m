//
//  DGCTabBar.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCTabBar.h"
#import "DGCTabBarItem.h"
#import "DGCDefine.h"
#import "DGCTool.h"
@interface DGCTabBar ()
@property (nonatomic,strong)NSArray * tabBarItems;
@end
@implementation DGCTabBar

#pragma mark - < view lifecycle > -
- (id)initWithOrgin:(CGPoint)orgin items:(NSArray *)items{
  
  self = [super initWithFrame:CGRectMake(orgin.x, orgin.y, screenW, tabBarH)];
  if (self) {
    self.tabBarItems = items;
    [self customInitUI];
    [self showItem:0];
  }
  
  return self;
}

#pragma mark - < method > -
- (void)showItem:(NSInteger)index{
  
  for (UIButton *b in self.tabBarItems) {
    [b setSelected:NO];
  }
  
  DGCTabBarItem * item = [self.tabBarItems objectAtIndex:index];
  item.selected = YES;
}

-(void)customInitUI{

  NSInteger width = floor(screenW/self.tabBarItems.count);
  
  for (int i = 0; i< self.tabBarItems.count; i++) {
    
    DGCTabBarItem *item = [self.tabBarItems objectAtIndex:i];
    if (i == 0) {
      [item setFrame:CGRectMake(0, 0, width, tabBarH)];
    }
    if (i == 1) {
      [item setFrame:CGRectMake(width, 0, width, tabBarH)];
    }
    if (i == 2) {
      [item setFrame:CGRectMake(width*2, 0, width, tabBarH)];
    }
    
    item.tag = i;
    [item addTarget:self action:@selector(touchUpForButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
  }
}

#pragma mark - < action > -
-(void)touchUpForButton:(DGCTabBarItem *)item{

  if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:willSelectItem:callBack:)]) {
    
    [self.delegate tabBar:self willSelectItem:item callBack:^(BOOL isSuccess) {
      
      if (!isSuccess) {
        for (DGCTabBarItem *item in self.tabBarItems) {
          [item setSelected:NO];
        }
        [item setSelected:YES];
        self.selectedItem = item;
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
          [self.delegate tabBar:self didSelectItem:item];
        }
      }
      
    }];
    
  }else{
    
    for (DGCTabBarItem *item in self.tabBarItems) {
      [item setSelected:NO];
    }
    [item setSelected:YES];
    self.selectedItem = item;
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
      [self.delegate tabBar:self didSelectItem:item];
    }
  
  }
}
@end
