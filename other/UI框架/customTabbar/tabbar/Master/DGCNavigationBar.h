//
//  DGCNavigationBar.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CustomNavigationBarButtonType){
  CustomNavigationBarButtonTypeOfLeft = 0,
  CustomNavigationBarButtonTypeOfRight = 1
};

@interface DGCNavigationBar : UIView

#pragma mark set button titlelabel bgimg
- (void)setNavBarButtonWithImage:(UIImage *)image
                highlightedImage:(UIImage *)highlightedImage
                      buttonType:(CustomNavigationBarButtonType)buttonType
                          target:(id)target
                          action:(SEL)action;

- (void)setNavBarButtonWithImage:(UIImage *)image
                highlightedImage:(UIImage *)highlightedImage
                         bgImage:(UIImage *)bgImage
              highlightedBgImage:(UIImage *)highlightedBgImage
                      buttonType:(CustomNavigationBarButtonType)buttonType
                          target:(id)target
                          action:(SEL)action;

- (void)setNavBarBackButtonTarget:(id)target
                           action:(SEL)action;

- (void)setNavBarTitle:(NSString *)title;
#pragma mark set hidden
-(void)setNavBgImage:(UIImage *)image;
-(void)setNaviLeftButtonHidden:(BOOL)hidden;
-(void)setNaviRightButtonHidden:(BOOL)hidden;
-(void)setNaviTitleLabelHidden:(BOOL)hidden;
@end
