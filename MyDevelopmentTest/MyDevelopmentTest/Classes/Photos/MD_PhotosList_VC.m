//
//  MD_PhotosList_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotosList_VC.h"
@import Photos;
@interface MD_PhotosList_VC ()
<
UITableViewDataSource,UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionFetchResults;
@property (nonatomic, strong) NSArray *sectionLocalizedTitles;
@end

@implementation MD_PhotosList_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self customInitData];
  [self customInitUI];
}

#pragma mark - < action > -

#pragma mark - < method > -
#pragma mark customInit
-(void)customInitData
{
  //全部
  PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
  allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
  PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
  
  //智能
  PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
  
  //用户
  PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
  
  // Store the PHFetchResult objects and localized titles for each section.
  self.sectionFetchResults = @[allPhotos, smartAlbums, topLevelUserCollections];
  self.sectionLocalizedTitles = @[@"", NSLocalizedString(@"Smart Albums", @""), NSLocalizedString(@"Albums", @"")];
  
  [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];

}

-(void)customInitUI
{

}

#pragma mark - < callback > -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
