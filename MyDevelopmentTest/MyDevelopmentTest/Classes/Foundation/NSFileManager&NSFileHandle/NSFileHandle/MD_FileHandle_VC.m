//
//  MD_FileHandle_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
@import AVFoundation;
#import "MD_FileHandle_VC.h"

@interface MD_FileHandle_VC ()
@property (nonatomic, strong)AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIProgressView *myPV;//进度条
@property (nonatomic, strong)NSMutableData *musicData;

@property (nonatomic, strong)NSFileHandle *fileReader;
@property (nonatomic, strong)NSFileHandle *fileWriter;
@end

@implementation MD_FileHandle_VC

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self test];
}

#pragma mark - 从文件中读取数据 模拟边下载边播放
-(void)test
{
  //初始化可变长data
  self.musicData = [NSMutableData data];
  
  //创建一个Timer模拟从网上下载数据
  [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(downloadMusicData:) userInfo:nil repeats:YES];
}

-(void)downloadMusicData:(NSTimer*)timer
{
  //用来读取文件数据的对象
  NSFileHandle *fileReader = [NSFileHandle fileHandleForReadingAtPath:@"/Users/hanyfeng/Desktop/素材/曹格 - 丑角.mp3"];
  
  //设置游标到某个字节的位置
  [fileReader seekToFileOffset:_musicData.length];
  
  //从文件中读取10kb数据，存放到可变长data中（如果数据不足咱们设定的长度的话，会自动把长度变短）
  NSData *data = [fileReader readDataOfLength:1024*10];
  [_musicData appendData:data];
  
  //获取总的文件长度（把游标设置到文件的最后，同时得到文件的总长度/注意返回值类型为long long）
  //仅仅把游标移动到文件最后并且得到了文件的总长度 并没有把文件加载到内存中
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

#pragma mark - 每点击一次复制指定大小的数据
-(void)test1{
  
  NSString *filePath = @"/Users/hanyfeng/Desktop/素材/btn_good_on@2x.png";
  self.fileReader = [NSFileHandle fileHandleForReadingAtPath:filePath];
  
  NSString *newFilePath = @"/Users/apple/Desktop/b.jpg";//复制文件的目标路径
  [[NSFileManager defaultManager] createFileAtPath:newFilePath contents:nil attributes:nil];//用FileManage创建文件
  
  //创建一个写数据的文件控制对象（注意：给的文件保存路径，一定要保证文件存在）
  self.fileWriter = [NSFileHandle fileHandleForWritingAtPath:newFilePath];
}
- (IBAction)btnTap:(id)sender {
  
  //读取20k的数据（用同一个fileReader对象读取数据，fileReader会自动移动游标）
  NSData *subData = [_fileReader readDataOfLength:20*1024];
  
  [_fileWriter writeData:subData];//把数据写到文件（用同一个fileWriter对象写数据，也会自动移动游标）
  
  [_fileWriter synchronizeFile];//将数据及时写出去
  
  //    //这种写data的方式会把原来的文件覆盖
  //    [subData writeToFile:@"/Users/apple/Desktop/a.mp4" atomically:YES];
}

@end
