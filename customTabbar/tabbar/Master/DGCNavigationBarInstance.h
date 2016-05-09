//
//  DGCNavigationBarInstance.h
//  tabbar
//
//  Created by 冯鸿辉 on 16/5/9.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DGCNavigationBarInstanceType) {
  DGCNavigationBarInstanceTypeBack
};





@class DGCNavigationBarInstance;
@protocol DGCNavigationBarInstanceDelegate <NSObject>

@optional
-(void)navigationBarInstance:(DGCNavigationBarInstance *)instance leftNavigationBarButtonTap:(id)sender;
-(void)navigationBarInstance:(DGCNavigationBarInstance *)instance rightNavigationBarButtonTap:(id)sender;
@end





@interface DGCNavigationBarInstance : UIView
@property(nonatomic,weak)id<DGCNavigationBarInstanceDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (id)initWithType:(DGCNavigationBarInstanceType)type;
@end
