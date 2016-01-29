//
//  MD_PhotoLibrary_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
@import Photos;
#import "MD_PhotoLibrary_VC.h"
static NSString * const AllPhotosReuseIdentifier = @"AllPhotosCell";
static NSString * const CollectionCellReuseIdentifier = @"CollectionCell";
@interface MD_PhotoLibrary_VC ()<UITableViewDataSource,UITableViewDelegate,PHPhotoLibraryChangeObserver>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *sectionFetchResults;
@property (nonatomic, strong) NSArray *sectionLocalizedTitles;
@end

@implementation MD_PhotoLibrary_VC
#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self customInitData];
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
  self.sectionLocalizedTitles = @[NSLocalizedString(@"All", @""), NSLocalizedString(@"Smart Albums", @""), NSLocalizedString(@"Albums", @"")];
  
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AllPhotosReuseIdentifier];
      }
      cell.textLabel.text = NSLocalizedString(@"All", nil);
    }
      break;
    case 1:
    case 2:
    {
      cell = [tableView dequeueReusableCellWithIdentifier:CollectionCellReuseIdentifier];
      if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CollectionCellReuseIdentifier];
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
@end
