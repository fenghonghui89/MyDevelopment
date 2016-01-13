//
//  TRViewController.m
//  Day8Music_data
//
//  Created by Tarena on 13-12-11.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *myPV;//进度条
@property (nonatomic, strong)NSMutableData *musicData;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化可变长data
    self.musicData = [NSMutableData data];
    
    //创建一个Timer模拟从网上下载数据
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(downloadMusicData:) userInfo:nil repeats:YES];
}

-(void)downloadMusicData:(NSTimer*)timer
{
    //用来读取文件数据的对象
    NSFileHandle *fileReader = [NSFileHandle fileHandleForReadingAtPath:@"/Users/apple/Desktop/music/时间煮雨.mp3"];
    
    //设置游标到某个字节的位置
    [fileReader seekToFileOffset:_musicData.length];
    
    //从文件中读取10kb数据，存放到可变长data中（如果数据不足咱们设定的长度的话，会自动把长度变短）
    NSData *data = [fileReader readDataOfLength:1024*10];
    [_musicData appendData:data];
    
    //获取总的文件长度（把游标设置到文件的最后，同时得到文件的总长度/注意返回值类型为long long）
    long long fileLength = [fileReader seekToEndOfFile];
    
    //进度条的进度
    _myPV.progress = _musicData.length*1.0/fileLength;
    
    //如果下载的数据达到100kb则开始播放
    if (_musicData.length>1024*100 && !self.player) {
        self.player = [[AVAudioPlayer alloc]initWithData:_musicData error:nil];
        [self.player play];
        NSLog(@"数据够了 开始播放！！！");
    }
    
    //当文件下载完成的时候 timer停止
    if (fileLength == _musicData.length) {
        [timer invalidate];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
