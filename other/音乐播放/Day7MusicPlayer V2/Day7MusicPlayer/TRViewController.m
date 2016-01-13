//
//  TRViewController.m
//  Day7PlayMusic
//
//  Created by Tarena on 13-12-10.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "Utils.h"
@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *artworkIV;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *allTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //取得该项目下的AppDelegate对象
    self.app = [UIApplication sharedApplication].delegate;
    
    //用timer改变slider的位置和label的文字
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateUI) userInfo:Nil repeats:YES];
    
    //执行播放音乐的方法
    [self playMusic];
}

//在页面即将消失的时候把timer停止，防止退出该页面后timer一直会调用self使self死不掉
-(void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

//改变slider的位置和label的文字
-(void)updateUI{
    self.mySlider.value = self.app.player.currentTime;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.app.player.currentTime/60,(int)self.app.player.currentTime%60];
}

//执行播放音乐的方法
-(void)playMusic
{
    NSString *musicPath = self.musicPaths[self.index];
    self.title = [[musicPath lastPathComponent]componentsSeparatedByString:@"."][0];//以“.”为标识分割歌曲名，取第一部分，作为标题
    NSURL *fileUrl = [NSURL fileURLWithPath:musicPath];
    
    //如果取得的歌曲路径与当前播放的不一样，则新建player播放新的歌曲，否则继续播放（用原来的player）
    if (![[fileUrl description] isEqualToString:[self.app.player.url description]]) {//url：当前歌曲的路径
        self.app.player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:Nil];
        self.app.player.volume = .5;
    }
    
    [self.app.player play];//播放歌曲（指向不变则继续播）
    self.mySlider.maximumValue = self.app.player.duration;
    self.allTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.app.player.duration/60,(int)self.app.player.duration%60];
    self.artworkIV.image = [Utils getArtworkByPath:self.musicPaths[_index]];//显示当前歌曲的专辑图像
}

//播放/暂停、上一首、下一首
- (IBAction)clicked:(id)sender {
    UIButton *btn = sender;
    switch (btn.tag) {
        case 0://播放/暂停
            if (self.app.player.isPlaying) {
                [self.app.player pause];
                [btn setTitle:@"播放" forState:UIControlStateNormal];
            }else{
                [self.app.player play];
                [btn setTitle:@"暂停" forState:UIControlStateNormal];
            }
            break;
        case 1://上一首
            _index--;
            if (_index==-1) {
                _index = self.musicPaths.count-1;
            }
            
            [self playMusic];
            break;
        case 2://下一首
            _index++;
            if (_index==self.musicPaths.count) {
                _index = 0;
            }
            [self playMusic];
            break;
    }
}

//调节音量
- (IBAction)volume:(id)sender {
    UISlider *slider = sender;
    self.app.player.volume = slider.value;
}

//拖动slider改变歌曲进度
- (IBAction)valueCahngeAction:(id)sender {
    self.app.player.currentTime = self.mySlider.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
