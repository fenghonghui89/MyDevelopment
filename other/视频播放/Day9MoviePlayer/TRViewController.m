//
//  TRViewController.m
//  Day9MoviePlayer
//
//  Created by Tarena on 13-12-12.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *movieUrl = [NSURL fileURLWithPath:@"/Users/apple/Desktop/jobs副本.mp4"];
    //创建视频播放对象
	self.player = [[MPMoviePlayerController alloc]initWithContentURL:movieUrl];
    
    //设置视频的显示范围
    self.player.view.frame = CGRectMake(0, 0, 100, 100);
    //把视频播放的视图加到self.view当中
    [self.view addSubview:self.player.view];
    
    //设置播放样式（默认、嵌套（与默认差不多）、全屏、none）
    [self.player setControlStyle:MPMovieControlStyleDefault];
    
    //播放
    [self.player play];
    //[self.player pause];
    
    //创建通知中心获取播放结束时间
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)movieFinish{
    NSLog(@"finish");
    [self.player stop]
}

//截屏
- (IBAction)clicked:(id)sender {
    
    //截取某个时间的图片(在IOS7下会报错，暂不用管)
    UIImage *image = [self.player thumbnailImageAtTime:self.player.currentPlaybackTime timeOption:MPMovieTimeOptionNearestKeyFrame];
    self.iv.image = image;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
