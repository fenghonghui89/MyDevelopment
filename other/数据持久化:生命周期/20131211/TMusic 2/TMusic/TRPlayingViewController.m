//
//  TRPlayingViewController.m
//  TMusic
//
//  Created by Alex Zhao on 13-8-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRPlayingViewController.h"
#import "TRPlayingListViewController.h"
#import "TRCategories.h"
#import "Utils.h"
#import "TRLoopButton.h"
#import "TRAppDelegate.h"
#define FLAG_MAIN_PAD_STATE_CLOSING     1
#define FLAG_MAIN_PAD_STATE_CLOSED      2
#define FLAG_MAIN_PAD_STATE_OPENING     3
#define FLAG_MAIN_PAD_STATE_OPENED      4

#define FLAG_PROGRESS_SLIDER_STATE_NORMAL           1
#define FLAG_PROGRESS_SLIDER_STATE_MOVING_BY_USER   2

#define FLAG_PLAYING_STATE_PAUSE    0
#define FLAG_PLAYING_STATE_PLAYING  1

@interface TRPlayingViewController ()

//  main pad views
@property (weak, nonatomic) IBOutlet UIView *mainPadView;
@property (nonatomic, weak)TRAppDelegate *app;
@property (nonatomic, strong)NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UIImageView * albumImageReflectionView;

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

//  control pad views
@property (weak, nonatomic) IBOutlet UIImageView *controlPadBackground;

@property (weak, nonatomic) IBOutlet TRLoopButton *playButton;

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *playedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

//  function pad views
@property (weak, nonatomic) IBOutlet UIView *functionPadView;
@property (weak, nonatomic) IBOutlet UIImageView *functionPadBackground;
@property (weak, nonatomic) IBOutlet TRLoopButton *playingModeButton;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

//  states
@property (nonatomic) unsigned int flagMainPadState;

@end

@implementation TRPlayingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.hidesBottomBarWhenPushed = YES;
    
    self.flagMainPadState = FLAG_MAIN_PAD_STATE_CLOSED;
}

- (void)viewDidLoad
{
    self.app = [UIApplication sharedApplication].delegate;
    [super viewDidLoad];
    [self setupSubviews];
    
    //更新界面的Timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}
-(void)updateUI{
    _progressSlider.value = self.app.player.currentTime;
    
    
    self.playedTimeLabel.text = [NSString stringWithMinuteAndSecondTime:self.app.player.currentTime];
    
}
- (void)setupSubviews
{
    
    self.albumImageReflectionView.image = self.albumImageView.image;
    self.albumImageReflectionView.transform = CGAffineTransformMakeScale(1, -1);
    self.albumImageReflectionView.alpha = 0.8;
    
    UIImage * backgroundImageForFunctionPad = [[UIImage imageNamed:@"playing_toolbar_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16) resizingMode:UIImageResizingModeStretch];
    self.functionPadBackground.image = backgroundImageForFunctionPad;
    
    UIImage * imageForProgressNow = [[UIImage imageNamed:@"playing_slider_play_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 2, 1)];
    [self.progressSlider setMinimumTrackImage:imageForProgressNow forState:UIControlStateNormal];
    UIImage * imageForProgressTotal = [[UIImage imageNamed:@"playing_slider_buf_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 2, 1)];
    [self.progressSlider setMaximumTrackImage:imageForProgressTotal forState:UIControlStateNormal];
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"playing_slider_thumb.png"] forState:UIControlStateNormal];
    
    [self.playButton setLoopImages:@[[UIImage imageNamed:@"playing_btn_pause_n.png"],
                                     [UIImage imageNamed:@"playing_btn_play_n.png"]]
              andHighlightedImages:@[[UIImage imageNamed:@"playing_btn_pause_h.png"],
                                     [UIImage imageNamed:@"playing_btn_play_h.png"]]];
    
    [self.playingModeButton setLoopImages:@[[UIImage imageNamed:@"playing_circle_btn.png"],
                                            [UIImage imageNamed:@"playing_single_btn.png"],
                                            [UIImage imageNamed:@"playing_random_btn.png"]]
                     andHighlightedImages:@[[UIImage imageNamed:@"playing_circle_btn_h.png"],
                                            [UIImage imageNamed:@"playing_single_btn_h.png"],
                                            [UIImage imageNamed:@"playing_random_btn_h.png"]]];
    
    UIImage * imageForVolumeNow = [[UIImage imageNamed:@"playing_volumn_slide_foreground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    [self.volumeSlider setMinimumTrackImage:imageForVolumeNow forState:UIControlStateNormal];
    UIImage * imageForVolumeTotal = [[UIImage imageNamed:@"playing_volumn_slide_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    [self.volumeSlider setMaximumTrackImage:imageForVolumeTotal forState:UIControlStateNormal];
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"playing_volumn_slide_sound_icon.png"] forState:UIControlStateNormal];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self playMusic];
    
   
}
-(void)playMusic{
    
    self.music = self.playingList[_index];
    NSURL *musicUrl = [NSURL fileURLWithPath:self.music.path];
    
    if (![[musicUrl description]isEqualToString:[self.app.player.url description]]) {
        
        self.app.player = [[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];
    }
    
    self.app.player.delegate = self;
    
    self.music.duration = self.app.player.duration;
    [self.app.player play];
    
    //更新界面显示的内容
     [self updateSubviews];
}

- (void)updateSubviews
{
    self.title = self.music.name;
    self.mainTitleLabel.text = self.music.artist;
    self.subtitleLabel.text = self.music.album;
    self.progressSlider.maximumValue = self.app.player.duration;
    self.totalTimeLabel.text = [NSString stringWithMinuteAndSecondTime:self.music.duration];
    self.albumImageView.image = [Utils getArtworkByPath:self.music.path];
    self.albumImageReflectionView.image = self.albumImageView.image;
}

- (IBAction)toggleMainPad:(id)sender {
    
    if (self.flagMainPadState == FLAG_MAIN_PAD_STATE_CLOSED  ||
        self.flagMainPadState == FLAG_MAIN_PAD_STATE_CLOSING     ) {
        
        self.flagMainPadState = FLAG_MAIN_PAD_STATE_OPENING;
        
        CGRect frame = self.mainPadView.frame;
        frame.origin.y -= self.functionPadView.frame.size.height;
        
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            self.mainPadView.frame = frame;
            self.progressSlider.alpha   = 0.0;
            self.playedTimeLabel.alpha  = 0.0;
            self.totalTimeLabel.alpha   = 0.0;
        } completion:^(BOOL finished){
            if (finished == YES) {
                self.flagMainPadState = FLAG_MAIN_PAD_STATE_OPENED;
            }
        }];
    } else if (self.flagMainPadState == FLAG_MAIN_PAD_STATE_OPENED ||
               self.flagMainPadState == FLAG_MAIN_PAD_STATE_OPENING     ) {
        
        self.flagMainPadState = FLAG_MAIN_PAD_STATE_CLOSING;
        
        CGRect frame = self.mainPadView.frame;
        if ([self respondsToSelector:@selector(topLayoutGuide)]) {
            frame.origin.y = [self.topLayoutGuide length];
        } else {
            frame.origin.y = 0;
        }
        
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            self.mainPadView.frame = frame;
            self.progressSlider.alpha   = 1.0;
            self.playedTimeLabel.alpha  = 1.0;
            self.totalTimeLabel.alpha   = 1.0;
        } completion:^(BOOL finished){
            if (finished == YES) {
                self.flagMainPadState = FLAG_MAIN_PAD_STATE_CLOSED;
            }
        }];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Playing List Segue"]) {
        UINavigationController * navigationController = segue.destinationViewController;
        TRPlayingListViewController * playingListViewController = (TRPlayingListViewController *)navigationController.topViewController;
        playingListViewController.playingList = self.playingList;
        playingListViewController.delegate = self;
    }
}

- (IBAction)updatePlayingProgress:(id)sender
{
    self.app.player.currentTime = _progressSlider.value;
}




- (IBAction)clicked:(UIButton *)sender {

    switch (sender.tag) {
        case 0://播放暂停
            
            if (self.app.player.isPlaying) {
                [self.app.player pause];
            }else [self.app.player play];
            
            break;
            
        case 1://上一曲
            if (_playingModeButton.currentIndex ==0||_playingModeButton.currentIndex==1) {
                _index--;
                if (_index==-1) {
                    _index = self.playingList.count-1;
                }

            }else{
                _index = arc4random()%self.playingList.count;
            }
            
            [self playMusic];
            break;
        case 2:
             if (_playingModeButton.currentIndex ==0||_playingModeButton.currentIndex==1) {
                    _index++;
                    if (_index==self.playingList.count) {
                        _index = 0;
                    }
             }else{
                  _index = arc4random()%self.playingList.count;
             }
            [self playMusic];
            break;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    switch (_playingModeButton.currentIndex) {
        case 0://正常模式
            _index++;
            if (_index==self.playingList.count) {
                _index=0;
            }
            break;
    case 2://随机
            _index = arc4random()%self.playingList.count;
            break;
    }
    [self playMusic];
}
@end
