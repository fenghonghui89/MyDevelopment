//
//  MD_PhotoLibrary_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
@import Photos;
#import "MD_PhotoLibrary_VC.h"
#import "MD_PhotoLibrary_GridVC.h"

static NSString * const AllPhotosReuseIdentifier = @"AllPhotosCell";
static NSString * const CollectionCellReuseIdentifier = @"CollectionCell";

@interface MD_PhotoLibrary_VC ()<UITableViewDataSource,UITableViewDelegate,PHPhotoLibraryChangeObserver>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *sectionFetchResults;
@property (nonatomic, strong) NSArray *sectionLocalizedTitles;
@end

@implementation MD_PhotoLibrary_VC
#pragma mark - < vc lifecycle > -
- (void)dealloc {
  [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self customInitData];
  [self customInitUI];
  [self.tableview reloadData];
}


#pragma mark - < method > -
-(void)customInitData{
  //全部
  PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
  allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
  PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
  
  //智能
  PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
  
  //用户
  PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
  
  self.sectionFetchResults = @[allPhotos, smartAlbums, topLevelUserCollections];
  self.sectionLocalizedTitles = @[NSLocalizedString(@"All", @""), NSLocalizedString(@"Smart Albums", @""), NSLocalizedString(@"Custom Albums", @"")];
  
  [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

-(void)customInitUI{
  self.navigationItem.title = @"Photos";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAddButtonItem)];
}

#pragma mark - < action > -
-(void)handleAddButtonItem{
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"New Album", @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
  
  [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = NSLocalizedString(@"Album Name", @"");
  }];
  
  [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleCancel handler:NULL]];
  
  [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Create", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    UITextField *textField = alertController.textFields.firstObject;
    NSString *title = textField.text;
    if (title.length == 0) {
      return;
    }
    
    // Create a new album with the title entered.
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
    } completionHandler:^(BOOL success, NSError *error) {
      if (!success) {
        NSLog(@"Error creating album: %@", error);
      }
    }];
  }]];
  
  [self presentViewController:alertController animated:YES completion:NULL];
}
#pragma mark - < callback > -
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  NSInteger count = self.sectionFetchResults.count;
  return count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if (section == 0) {
    return 1;
  }
  NSInteger count = [[self.sectionFetchResults objectAtIndex:section] count];
  return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell;
  switch (indexPath.section) {
    case 0:
    {
      cell = [tableView dequeueReusableCellWithIdentifier:AllPhotosReuseIdentifier];
      if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AllPhotosReuseIdentifier];
      }
      cell.textLabel.text = NSLocalizedString(@"All", nil);
      
      PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)fetchResult.count];
    }
      break;
    case 1:
    case 2:
    {
      cell = [tableView dequeueReusableCellWithIdentifier:CollectionCellReuseIdentifier];
      if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CollectionCellReuseIdentifier];
      }
      PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
      PHCollection *collection = fetchResult[indexPath.row];
      PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
      PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
      
      cell.textLabel.text = collection.localizedTitle;
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)assetsFetchResult.count];
    }
      break;
    default:
      break;
  }
  return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return [self.sectionLocalizedTitles objectAtIndex:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  MD_PhotoLibrary_GridVC *assetGridViewController = [[MD_PhotoLibrary_GridVC alloc] initWithNibName:@"MD_PhotoLibrary_GridVC" bundle:nil];
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
  assetGridViewController.title = cell.textLabel.text;
  
  PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
  
  if(indexPath.section == 0){
    assetGridViewController.assetsFetchResults = fetchResult;
  }else{
    PHCollection *collection = fetchResult[indexPath.row];
    if (![collection isKindOfClass:[PHAssetCollection class]]) {
      return;
    }
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    assetGridViewController.assetsFetchResults = assetsFetchResult;
    assetGridViewController.assetCollection = assetCollection;
  }
  
  [self.navigationController pushViewController:assetGridViewController animated:YES];
}

#pragma mark PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
  /*
   Change notifications may be made on a background queue. Re-dispatch to the
   main queue before acting on the change as we'll be updating the UI.
   */
  dispatch_async(dispatch_get_main_queue(), ^{
    // Loop through the section fetch results, replacing any fetch results that have been updated.
    NSMutableArray *updatedSectionFetchResults = [self.sectionFetchResults mutableCopy];
    __block BOOL reloadRequired = NO;
    
    [self.sectionFetchResults enumerateObjectsUsingBlock:^(PHFetchResult *collectionsFetchResult, NSUInteger index, BOOL *stop) {
      PHFetchResultChangeDetails *changeDetails = [changeInstance changeDetailsForFetchResult:collectionsFetchResult];
      
      if (changeDetails != nil) {
        [updatedSectionFetchResults replaceObjectAtIndex:index withObject:[changeDetails fetchResultAfterChanges]];
        reloadRequired = YES;
      }
    }];
    
    if (reloadRequired) {
      self.sectionFetchResults = updatedSectionFetchResults;
      [self.tableview reloadData];
    }
    
  });
}
@end
