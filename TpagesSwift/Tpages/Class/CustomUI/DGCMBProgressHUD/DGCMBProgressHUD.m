//
//  DGCMBProgressHUD.m
//  uitest
//
//  Created by hanyfeng on 15/11/17.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "DGCMBProgressHUD.h"
#import "MBProgressHUD.h"

@interface DGCMBProgressHUD()<MBProgressHUDDelegate>
{
  BOOL flag;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,copy) void(^actionBlock)(void);
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation DGCMBProgressHUD

#pragma mark - < lifecycle > -
-(instancetype)initWithView:(UIView *)view animated:(BOOL)animated block:(void(^)(void))block
{
  self = [super init];
  if (self) {
    MBProgressHUD *mbhud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    self.hud = mbhud;
    if (mbhud) {//新建了一个hud
      flag = YES;
      UIImageView *imageView = [self createIV];
      [self rotate];
      mbhud.mode = MBProgressHUDModeCustomView;
      mbhud.customView = imageView;
      mbhud.animationType = MBProgressHUDAnimationZoomIn;
      mbhud.detailsLabelText = NSLocalizedString(@"正在加载，请稍后...", nil);
      mbhud.color = [UIColor blackColor];
      mbhud.dimBackground = YES;
      mbhud.labelFont = [UIFont systemFontOfSize:19];
      mbhud.alpha = 0.5;
      mbhud.delegate = self;
      mbhud.removeFromSuperViewOnHide = YES;
      self.actionBlock = block;
      [self startTimer];
    }else{//已经存在hud
      return self;
    }
  }
  return self;
}

-(instancetype)initWithButton:(UIView *)view animated:(BOOL)animated block:(void(^)(void))block
{
  self = [super init];
  if (self) {
    MBProgressHUD *mbhud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    self.hud = mbhud;
    if (mbhud) {//新建了一个hud
      flag = YES;
      UIButton *btn = [self createBtn];
      mbhud.mode = MBProgressHUDModeCustomView;
      mbhud.customView = btn;
      mbhud.animationType = MBProgressHUDAnimationZoomIn;
      mbhud.detailsLabelText = NSLocalizedString(@"网络好像发脾气了，试试重新下拉加载~", nil);
      mbhud.color = [UIColor blackColor];
      mbhud.dimBackground = YES;
      mbhud.labelFont = [UIFont systemFontOfSize:19];
      mbhud.alpha = 1;
      mbhud.delegate = self;
      mbhud.removeFromSuperViewOnHide = YES;
      self.actionBlock = block;
    }else{//已经存在hud
      return self;
    }
  }
  return self;
}

#pragma mark - < method > -
-(void)startTimer{
//  dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//  dispatch_async(myQueue, ^{
//    
//  });
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeUI) userInfo:nil repeats:NO];
}

-(void)changeUI{
  if (self.timer.valid) {
    UIButton *btn = [self createBtn];
    self.hud.customView = btn;
    self.hud.alpha = 1;
    self.hud.detailsLabelText = @"网络好像发脾气了，试试重新下拉加载~";
  }else{
    return;
  }
}

-(UIImageView *)createIV
{
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  [imageView setBackgroundColor:[UIColor clearColor]];
  [imageView setImage:[UIImage imageNamed:@"Icon-Loading.png"]];
  _imageView = imageView;
  return imageView;
}

-(UIButton *)createBtn{
  UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
  [btn setTitle:@"好" forState:UIControlStateNormal];
  [btn.layer setCornerRadius:20*0.5];
  [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [btn setBackgroundColor:[UIColor blueColor]];
  [btn addTarget:self action:@selector(btnTap) forControlEvents:UIControlEventTouchUpInside];
  return btn;
}

- (void)rotate
{
  if (flag) {
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                       CGAffineTransform transform = self.imageView.transform;
                       transform = CGAffineTransformRotate(transform,M_PI);
                       _imageView.transform = transform;
                     } completion:^(BOOL finished) {
                       flag = NO;
                       [self rotate];
                     }];
    
  }
  else {
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                       CGAffineTransform transform = self.imageView.transform;
                       transform = CGAffineTransformRotate(transform,0);
                       _imageView.transform = transform;
                     } completion:^(BOOL finished) {
                       flag = YES;
                       [self rotate];
                     }];
  }
}

#pragma mark - < action > -
-(void)btnTap{
  [DGCMBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:NO];
  self.actionBlock();
}

+ (DGCMBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated type:(NSInteger)type block:(void(^)(void))block
{
  DGCMBProgressHUD *hud;
  if (type == 0) {
    hud = [[DGCMBProgressHUD alloc] initWithView:view animated:animated block:block];
  }else{
    hud = [[DGCMBProgressHUD alloc] initWithButton:view animated:animated block:block];
  }
  return hud;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated
{
 return [MBProgressHUD hideHUDForView:view animated:animated];
}

#pragma mark - < callback > -
-(void)hudWasHidden:(MBProgressHUD *)hud{
  NSLog(@"定时器销毁");
//  [self.timer invalidate];
}
@end
