//
//  MD_MediaPlayer_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 16/4/17.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_MediaPlayer_VC.h"
@import MediaPlayer;

@interface MD_MediaPlayer_VC ()
@property (nonatomic, strong)MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (strong, nonatomic) IBOutlet UIView *playView;
@end

@implementation MD_MediaPlayer_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self addObserver];
  [self customInit];
  
}

-(void)viewDidDisappear:(BOOL)animated{

  [self removeObserver];
  
  [super viewDidDisappear:animated];
}
#pragma mark - < method > -
#pragma mark custom init
-(void)customInit{
  
  NSURL *movieUrl = [NSURL fileURLWithPath:@"/Users/hanyfeng/Desktop/素材/testmp4.MP4"];
  self.player = [[MPMoviePlayerController alloc]initWithContentURL:movieUrl];
  self.player.view.frame = self.playView.bounds;
  [self.playView addSubview:self.player.view];
  
  
  [self.player setControlStyle:MPMovieControlStyleDefault];//设置播放样式（默认、嵌套（与默认差不多）、全屏、none）
  
  [self.player play];
  
}

#pragma mark observer noti
-(void)addObserver{
  
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)removeObserver{

  [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)movieFinish{
  
  [self.player stop];
}

#pragma mark 旋屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
  
  return UIInterfaceOrientationMaskPortrait;
}



#pragma mark - < action > -
- (IBAction)btn1Tap:(id)sender {
  
  //截取某个时间的图片(在IOS7下会报错，暂不用管)
  UIImage *image = [self.player thumbnailImageAtTime:self.player.currentPlaybackTime timeOption:MPMovieTimeOptionNearestKeyFrame];
  self.iv.image = image;
}

- (IBAction)btnStopTap:(id)sender {
  
  [self.player pause];
}

@end
