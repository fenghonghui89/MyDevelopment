//
//  DGCBaseVC.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCNavigationViewController.h"
#import "DGCBaseViewController.h"
#import "DGCNavigationBar.h"
#import "DGCDefine.h"
#import "DGCTool.h"
@interface DGCBaseViewController ()
@property(nonatomic,weak)DGCNavigationViewController *navigationController_t;
@end

@implementation DGCBaseViewController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  [self customInitSelfView];
  [self customInitBgImageView];
  [self customInitNavigationBar];
  [self customInitMainView];
}

-(void)viewWillAppearCustom{
  DLog("%@",NSStringFromSelector(_cmd));
}

-(void)viewDidAppearCustom{
  DLog("%@",NSStringFromSelector(_cmd));
}

-(void)viewWillDisappearCustom{
  DLog("%@",NSStringFromSelector(_cmd));
}

-(void)viewDidDisappearCustom{
  DLog("%@",NSStringFromSelector(_cmd));
}

#pragma mark - < method > -
-(void)customInitSelfView{
  
  self.view.backgroundColor = [UIColor purpleColor];
  self.view.frame = CGRectMake(0, 0, screenW, screenH);
}

-(void)customInitBgImageView{

  UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:bgImageView];
  bgImageView.hidden = YES;
  self.bgImageView = bgImageView;
}

-(void)customInitNavigationBar{

  DGCNavigationBar *navigationBar = [[DGCNavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenW, naviH+stateH)];
  [self.view insertSubview:navigationBar aboveSubview:self.bgImageView];
  navigationBar.hidden = NO;
  self.navigationBar = navigationBar;
}

-(void)customInitMainView{

  UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(0, naviH+stateH, screenW, viewH-naviH-stateH-tabBarH)];
  [self.view insertSubview:addView aboveSubview:self.bgImageView];
  addView.backgroundColor = [UIColor orangeColor];
  self.addView = addView;
}
#pragma mark - < action > -
-(void)setBackgroundImage:(UIImage *)image{
  
  if (!self.bgImageView) {
    [self customInitBgImageView];
  }
  self.bgImageView.image = image;
  self.bgImageView.hidden = NO;
  self.addView.backgroundColor = [UIColor clearColor];
  self.navigationBar.backgroundColor = [UIColor clearColor];
}
#pragma mark - < callback > -
@end
