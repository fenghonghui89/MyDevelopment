//
//  DGCBaseVC.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGCMainViewController.h"
#import "DGCNavigationBar.h"
#import "DGCTabBarController.h"

@interface DGCBaseViewController : UIViewController
@property(nonatomic,strong)DGCMainViewController *mainViewController;
@property(nonatomic,strong)DGCNavigationBar *navigationBar;
@property(nonatomic,strong)UIView *addView;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)DGCTabBarController *tabBarController_t;

-(void)setBackgroundImage:(UIImage *)image;
-(void)viewWillAppearCustom;
-(void)viewDidAppearCustom;
-(void)viewWillDisappearCustom;
-(void)viewDidDisappearCustom;
@end
