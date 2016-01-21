//
//  TRTableViewController.m
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRTableViewController.h"
#import "TRViewController.h"
#import "TRAlbum.h"
#import "TRUtils.h"
#import "TRCell.h"
@interface TRTableViewController ()
@property(nonatomic,strong)NSMutableArray* albums;
@end

@implementation TRTableViewController

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
    self.albums = [TRUtils getAlbumsFromPath:@"/Users/hanyfeng/Desktop/photo"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//用系统默认的cell（cell的imageView无法修改frame）
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    TRAlbum* album = self.albums[indexPath.row];
//    cell.textLabel.text = album.name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",album.imagePaths.count];
//    cell.imageView.image = [UIImage imageWithContentsOfFile:album.imagePaths[0]];//无法修改系统cell的frame
//    
//    return cell;

//用自定义cell（方法1-在该方法内定义cell的内容）
//    static NSString *CellIdentifier = @"TRCell";
//    TRCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    TRAlbum* album = self.albums[indexPath.row];
//    cell.mainLabel.text = album.name;
//    cell.subLabel.text = [NSString stringWithFormat:@"%d",album.imagePaths.count];
//    cell.imageView.image = [UIImage imageWithContentsOfFile:album.imagePaths[0]];
//    return cell;

//用自定义cell（方法1-把对应专辑对象传递到cell，在cell内定义cell的内容）
    static NSString *CellIdentifier = @"TRCell";
    TRCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    TRAlbum* album = self.albums[indexPath.row];
    cell.album = album;
    return cell;
}

//获取参数方法1（cell连线view）
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"imageView"]) {
//        UITableViewCell *cell = sender;
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//        TRAlbum *album = self.albums[indexPath.row];
//        TRViewController* vc = segue.destinationViewController;
//        vc.album = album;
//    }
//}

//获取参数方法2（view连线view）
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRAlbum* album = self.albums[indexPath.row];
    [self performSegueWithIdentifier:@"imageView" sender:album];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TRViewController* vc = segue.destinationViewController;
    vc.album = sender;
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
