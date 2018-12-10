//
//  TRMusicListViewController.m
//  Day7MusicPlayer
//
//  Created by Tarena on 13-12-10.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRMusicListViewController.h"
#import "TRViewController.h"
#import "Utils.h"
@interface TRMusicListViewController ()
@property (nonatomic, strong)NSMutableArray *musicPaths;
@end

@implementation TRMusicListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.musicPaths = [NSMutableArray array];
    
    //用文件管理器把歌曲路径添加到数组
    NSString *directoryPath = @"/Users/apple/Desktop/music";
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *musicNames = [fm contentsOfDirectoryAtPath:directoryPath error:Nil];
    for (NSString *musicName in musicNames) {
        NSString *musicPath = [directoryPath stringByAppendingPathComponent:musicName];
        [self.musicPaths addObject:musicPath];
    }   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.musicPaths.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *musicName = [self.musicPaths[indexPath.row] lastPathComponent];
    
    cell.textLabel.text = musicName;
    cell.imageView.image = [Utils getArtworkByPath:self.musicPaths[indexPath.row]];
    
    return cell;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"playvc" sender:indexPath];//执行响应标示符的segue跳转，并把下标作为参数
}

//通过segue跳转到歌曲播放页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    TRViewController *vc = segue.destinationViewController;
    vc.musicPaths = self.musicPaths;
    vc.index = indexPath.row;
}



@end
