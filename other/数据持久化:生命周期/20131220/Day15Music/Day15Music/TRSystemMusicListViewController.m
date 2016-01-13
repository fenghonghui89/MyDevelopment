//
//  TRSystemMusicListViewController.m
//  Day15Music
//
//  Created by Tarena on 13-12-20.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRSystemMusicListViewController.h"

@interface TRSystemMusicListViewController ()
@property (nonatomic, strong)MPMusicPlayerController *player;
@property (nonatomic, strong) NSMutableArray *musicItems;
@end

@implementation TRSystemMusicListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取系统音乐中的所有歌曲
    //创建数组用来保存所有的歌曲对象
    self.musicItems = [NSMutableArray array];
    
    //创建查询歌曲的对象
    MPMediaQuery *query = [MPMediaQuery songsQuery];
    
    //遍历歌曲查询对象下面的所有的集合
    for (MPMediaItemCollection *collection in query.collections) {
        //遍历每个集合下面的歌曲对象 并加到自己的数组当中
        for (MPMediaItem *musicItem in collection.items) {
            [self.musicItems addObject:musicItem];
        }
    }
    
    //创建播放器对象的两种方式
    //1.applicationMusicPlayer 应用自身的播放器 退出时停止播放
    //2.iPodMusicPlayer 会直接调用系统的音乐程序播放此歌曲 退出仍然播放
    self.player = [MPMusicPlayerController applicationMusicPlayer];
    MPMediaItemCollection *collection = [[MPMediaItemCollection alloc]initWithItems:self.musicItems];//创建歌曲队列（集合）
    [self.player setQueueWithItemCollection:collection];
    [self.player play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.musicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MPMediaItem *musicItem = [self.musicItems objectAtIndex:indexPath.row];
    //获取歌曲名称
    NSString *title = [musicItem valueForKey:MPMediaItemPropertyTitle];
    cell.textLabel.text = title;
    //获取专辑图片
    MPMediaItemArtwork *artwork = [musicItem valueForKey:MPMediaItemPropertyArtwork];
    UIImage *artworkImage = [artwork imageWithSize:CGSizeMake(70, 70)];
    cell.imageView.image = artworkImage;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPMediaItem *item = self.musicItems[indexPath.row];
    [self.player setNowPlayingItem:item];
    //当前播放时间
    //self.player.currentPlaybackTime
    //总时间
    //[self.player.nowPlayingItem valueForKey:MPMediaItemPropertyPlaybackDuration]
    //上一曲
    //self.player skipToPreviousItem
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
