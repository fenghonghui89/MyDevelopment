//
//  TRViewController.m
//  Day7PlayMusic
//
//  Created by Tarena on 13-12-10.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *allTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation TRViewController

//播放、暂停、快进、快退
- (IBAction)clicked:(id)sender {
    UIButton *btn = sender;
    switch (btn.tag) {
        case 0:
            if (self.app.player.isPlaying) {
                [self.app.player pause];
                [btn setTitle:@"播放" forState:UIControlStateNormal];
            }else{
                [self.app.player play];
                [btn setTitle:@"暂停" forState:UIControlStateNormal];
            }
            break;
        case 1:
            self.app.player.currentTime-=5;
            break;
        case 2:
            self.app.player.currentTime+=5;
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //取得该项目下的AppDelegate对象
    self.app = [UIApplication sharedApplication].delegate;
    
    //取得所点击歌曲的路径
    NSString *musicPath = self.musicPaths[_index];
    NSURL *fileUrl = [NSURL fileURLWithPath:musicPath];
    
	self.app.player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:Nil];
    [self.app.player prepareToPlay];
    
    self.mySlider.maximumValue = self.app.player.duration;
    self.allTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.app.player.duration/60,(int)self.app.player.duration%60];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateUI) userInfo:Nil repeats:YES];
    
    [self.app.player play];//一进来就播放所点击的歌曲

}

//在页面即将消失的时候把timer停止，防止退出该页面后timer一直会调用self使self死不掉
-(void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
}

-(void)updateUI{
    self.mySlider.value = self.app.player.currentTime;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.app.player.currentTime/60,(int)self.app.player.currentTime%60];
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

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
