//
//  DGCNavigationBar.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCNavigationBar.h"
#import "DGCDefine.h"
#import "DGCTool.h"
#import "UIView+MDCategory.h"
#define BS_X_SPACING  15.0f
#define BS_Y_SPACING  0.0f
#define BS_BACK_BUTTON_NAME       @"nav_back"
#define BS_BACK_BUTTON_HIGHT_NAME @"nav_back_highlight"

@interface DGCNavigationBar ()
@property (nonatomic, strong) UIButton *navBarLeftButton;
@property (nonatomic, strong) UIButton *navBarRightButton;
@property (nonatomic, strong) UILabel *navBarTitleLabel;
@property (nonatomic, strong) UIImageView * navBarBgImageView;
@end


@implementation DGCNavigationBar

#pragma mark - < view lifecycle > -
-(id)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
    //init bgimage
    if (self.navBarBgImageView == nil) {
      
      UIImage *navBarBgImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"" ofType:@""]];
      UIImageView *navBarBgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
      navBarBgImageView.backgroundColor = [UIColor clearColor];
      navBarBgImageView.image = navBarBgImage;
      [self addSubview:navBarBgImageView];
      self.navBarBgImageView = navBarBgImageView;
      self.navBarBgImageView.hidden = YES;
    }
  }
  return self;
}

#pragma mark - < method > -
#pragma mark set button titlelabel bgimg
- (void)setNavBarButtonWithImage:(UIImage *)image
                highlightedImage:(UIImage *)highlightedImage
                      buttonType:(CustomNavigationBarButtonType)buttonType
                          target:(id)target
                          action:(SEL)action{
  
  NSAssert(image, @"setNavBarButtonWithImage - >image not be nil");
  NSAssert(highlightedImage, @"setNavBarButtonWithImage - > highlightedImage not be nil");
  
  CGFloat width = image.size.width;
  CGFloat height = image.size.height;
  CGFloat x = BS_X_SPACING;
  CGFloat y = (naviH - image.size.height - BS_Y_SPACING) * 0.5 ;
  y += stateH;
  
  if (buttonType == CustomNavigationBarButtonTypeOfLeft) {
    if (self.navBarLeftButton) {
      [self.navBarLeftButton removeFromSuperview];
    }
  }else if(buttonType == CustomNavigationBarButtonTypeOfRight){
    if (self.navBarRightButton) {
      [self.navBarRightButton removeFromSuperview];
    }
    x = screenW - BS_X_SPACING - width;
  }
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(x, y, width, height);
  [btn setBackgroundImage:image forState:UIControlStateNormal];
  [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
  [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:btn];
  
  if (buttonType == CustomNavigationBarButtonTypeOfLeft) {
    self.navBarLeftButton = btn;
  } else if (buttonType == CustomNavigationBarButtonTypeOfRight) {
    self.navBarRightButton = btn;
  }
  
}

- (void)setNavBarButtonWithImage:(UIImage *)image
                highlightedImage:(UIImage *)highlightedImage
                         bgImage:(UIImage *)bgImage
              highlightedBgImage:(UIImage *)highlightedBgImage
                      buttonType:(CustomNavigationBarButtonType)buttonType
                          target:(id)target
                          action:(SEL)action{

  NSAssert(image, @"setNavBarButton -> image not be nil ");
  NSAssert(image, @"setNavBarButton -> highlightedImage not be nil ");
  NSAssert(image, @"setNavBarButton -> bgImage not be nil ");
  NSAssert(image, @"setNavBarButton -> highlightedBgImage not be nil ");

  
  CGFloat width = image.size.width;
  CGFloat height = image.size.height;
  CGFloat x = BS_X_SPACING;
  CGFloat y = (naviH - height - BS_Y_SPACING) * 0.5;
  y += stateH;
  
  CGFloat bgWidth = bgImage.size.width;
  CGFloat bgHight = bgImage.size.height;
  
  if (buttonType == CustomNavigationBarButtonTypeOfLeft) {
    if (self.navBarLeftButton) {
      [self.navBarLeftButton removeFromSuperview];
    }
  }else if (buttonType == CustomNavigationBarButtonTypeOfRight){
    if (self.navBarRightButton) {
      [self.navBarRightButton removeFromSuperview];
    }
    x = screenW - BS_X_SPACING - bgWidth;
  }
  
  
  
  UIEdgeInsets edgeInsets = UIEdgeInsetsMake((bgWidth - width)  / 2, (bgHight - height) / 2, (bgWidth - width)  / 2, (bgHight - height) / 2);
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(x, y, width, height);
  [btn setImageEdgeInsets:edgeInsets];
  [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
  [btn setBackgroundImage:highlightedBgImage forState:UIControlStateHighlighted];
  [btn setImage:image forState:UIControlStateNormal];
  [btn setImage:highlightedImage forState:UIControlStateHighlighted];
  [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:btn];
  
  if (buttonType == CustomNavigationBarButtonTypeOfLeft) {
    self.navBarRightButton = btn;
  }else if(buttonType == CustomNavigationBarButtonTypeOfRight){
    self.navBarLeftButton = btn;
  }
  
}

- (void)setNavBarBackButtonTarget:(id)target
                           action:(SEL)action{

  UIImage *backImage = [UIImage imageNamed:BS_BACK_BUTTON_NAME];
  UIImage *backHightImage = [UIImage imageNamed:BS_BACK_BUTTON_HIGHT_NAME];
  
  CGFloat width = backImage.size.width;
  CGFloat height = backImage.size.height;
  CGFloat x = BS_X_SPACING;
  CGFloat y = (naviH - height - BS_Y_SPACING) * 0.5;
  y += stateH;
  
  if (self.navBarLeftButton) {
    [self.navBarLeftButton removeFromSuperview];
  }
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn setFrame:CGRectMake(x, y, width, height)];
  [btn setBackgroundImage:backImage forState:UIControlStateNormal];
  [btn setBackgroundImage:backHightImage forState:UIControlStateHighlighted];
  [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  [self addSubview: btn];
  
  self.navBarLeftButton = btn;
}

- (void)setNavBarTitle:(NSString *)title{

  NSAssert(title, @"setNavBarTitle -> title not be nil");
  
  if (self.navBarTitleLabel) {
    [self.navBarTitleLabel removeFromSuperview];
  }
  
  UILabel *navBarTitleLabel = [[UILabel alloc] init];
  navBarTitleLabel.textAlignment = NSTextAlignmentCenter;
  navBarTitleLabel.backgroundColor = [UIColor clearColor];
  navBarTitleLabel.text = title;
  navBarTitleLabel.textColor = [UIColor whiteColor];
  navBarTitleLabel.font = [UIFont systemFontOfSize:17];
  [self addSubview:navBarTitleLabel];
  [navBarTitleLabel setMarginTop:30 left:50 bottom:10 right:50];
  self.navBarTitleLabel = navBarTitleLabel;
}

#pragma mark set hidden
-(void)setNavBgImage:(UIImage *)image{
  
  self.navBarBgImageView.image = image;
}

-(void)setNaviLeftButtonHidden:(BOOL)hidden{
  
  if (self.navBarLeftButton) {
    self.navBarLeftButton.hidden = hidden;
  }
}

-(void)setNaviRightButtonHidden:(BOOL)hidden{

  if (self.navBarRightButton) {
    self.navBarRightButton.hidden = hidden;
  }
}

-(void)setNaviTitleLabelHidden:(BOOL)hidden{
  
  if (self.navBarTitleLabel) {
    self.navBarTitleLabel.hidden = hidden;
  }
}



@end
