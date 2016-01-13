//
//  TRViewController.m
//  Day7MusicPlayer_my
//
//  Created by HanyFeng on 13-12-12.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TRViewController ()

@property(nonatomic,strong)AVAudioPlayer* player;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISlider *voiceSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *duration;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL* fileURL = [NSURL fileURLWithPath:@"/Users/apple/Desktop/music/趁早.mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:Nil];
    [self.player prepareToPlay];//把歌曲加载到内存当中
    
    self.slider.maximumValue = self.player.duration;
    self.player.volume = self.voiceSlider.value;
    self.duration.text = [NSString stringWithFormat:@"%2d:%2d",(int)self.player.duration/60,(int)self.player.duration%60];
    
    //用timer使slider的值根据歌曲的进度改变位置
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(ShowSliderValue) userInfo:nil repeats:YES];
    
}

//自动根据歌曲进度改变slider的位置
-(void)ShowSliderValue
{
    self.slider.value = self.player.currentTime;
    self.currentTime.text = [NSString stringWithFormat:@"%2d:%2d",(int)self.player.currentTime/60,(int)self.player.currentTime%60];
}

//拖动slider
- (IBAction)sliderChange:(id)sender
{
    [self.player play];
    self.player.currentTime = self.slider.value;
}

//改变音量
- (IBAction)voiceChange:(id)sender
{
    self.player.volume = self.voiceSlider.value;
}

//播放与暂停
- (IBAction)buttonPlay:(id)sender
{
    UIButton* button = sender;
    
    if (self.player.isPlaying) {/* is it playing or not? */
        [self.player pause];
//        [self.player stop];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [self.player play];
        [button setTitle:@"播放" forState:UIControlStateNormal];
    }
}

//快退
- (IBAction)buttonLeft:(id)sender
{
    self.player.currentTime -= 5;
    self.slider.value = self.player.currentTime;
}

//快进
- (IBAction)buttonRight:(id)sender
{
    self.player.currentTime += 5;
    self.slider.value = self.player.currentTime;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
